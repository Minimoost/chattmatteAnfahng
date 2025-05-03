import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import '../../models/character.dart';
import '../../models/message.dart';
import '../../services/ai_service.dart';
import '../../widgets/mood_indicator.dart';
import '../../widgets/mood_bar.dart';
import '../message_history/message_history_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatHistory _chatHistory = ChatHistory();
  late AiService _aiService;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    final character = Provider.of<Character>(context, listen: false);
    _aiService = AiService(character: character);
    
    // Add initial greeting based on relationship status
    _addInitialGreeting(character);
  }

  void _addInitialGreeting(Character character) {
    String greeting;
    
    // Base greeting on relationship status
    switch (character.relationshipStatus) {
      case RelationshipStatus.justMet:
        greeting = "Hallo! Schön dich kennenzulernen. Wie geht's dir?";
        break;
      case RelationshipStatus.acquaintance:
        greeting = "Hey! Lange nicht gesehen. Was gibt's Neues?";
        break;
      case RelationshipStatus.friends:
        greeting = "Hi du! Wie läuft's? Erzähl mal, was bei dir so los ist!";
        break;
      case RelationshipStatus.closeFriends:
        greeting = "Hey! Hab dich vermisst! Was hast du in letzter Zeit so gemacht?";
        break;
    }
    
    // Modify greeting based on personality type
    switch (character.personalityType) {
      case PersonalityType.shy:
        greeting = "Hmm... " + greeting.replaceAll("!", ".");
        break;
      case PersonalityType.confident:
        greeting = greeting.replaceAll("?", "?!");
        break;
      case PersonalityType.humorous:
        greeting = greeting + " 😊";
        break;
      case PersonalityType.thoughtful:
        greeting = "Ich denke gerade darüber nach... " + greeting;
        break;
    }
    
    _chatHistory.addMessage(
      Message(
        text: greeting,
        sender: MessageSender.character,
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    
    final userMessage = _messageController.text.trim();
    _messageController.clear();
    
    // Add user message to chat
    _chatHistory.addMessage(
      Message(
        text: userMessage,
        sender: MessageSender.user,
      ),
    );
    
    _scrollToBottom();
    
    // Show typing indicator
    setState(() {
      _isTyping = true;
    });
    
    // Generate AI response - this now handles all emotional state updates
    final response = await _aiService.generateResponse(userMessage);
    
    // Hide typing indicator and add AI response
    setState(() {
      _isTyping = false;
    });
    
    _chatHistory.addMessage(
      Message(
        text: response,
        sender: MessageSender.character,
      ),
    );
    
    // Force UI update to reflect mood changes
    setState(() {});
    
    _scrollToBottom();
  }
  
  // Helper method to get mood category text
  String _getMoodCategoryText(Character character) {
    switch (character.moodCategory) {
      case MoodCategory.neutralCurious:
        return 'Neutral / Neugierig';
      case MoodCategory.friendly:
        return 'Freundschaftlich';
      case MoodCategory.inLoveEmotional:
        return 'Verliebt / Emotional';
      case MoodCategory.confusedDistant:
        return 'Verwirrt / Distanziert';
      case MoodCategory.blockedDismissive:
        return 'Blockiert / Abweisend';
    }
  }
  
  // Helper method to get typing indicator color based on mood
  Color _getTypingIndicatorColor(Character character) {
    if (character.isBlockedDismissive) {
      return Colors.red.shade300;
    } else if (character.isConfusedDistant) {
      return Colors.orange.shade300;
    } else if (character.isNeutralCurious) {
      return Colors.grey;
    } else if (character.isFriendly) {
      return Colors.green.shade300;
    } else if (character.isInLoveEmotional) {
      return Colors.purple.shade300;
    } else {
      return Colors.grey;
    }
  }
  
  // Helper method to get typing text based on mood
  String _getTypingText(Character character) {
    if (character.isBlockedDismissive) {
      return '...';
    } else if (character.isConfusedDistant) {
      return 'Überlegt...';
    } else if (character.isNeutralCurious) {
      return 'Tippt...';
    } else if (character.isFriendly) {
      return 'Schreibt...';
    } else if (character.isInLoveEmotional) {
      return 'Antwortet dir...';
    } else {
      return 'Tippt...';
    }
  }
  
  // This method is now a placeholder since sentiment analysis is handled in the AI service
  void _updateEmotionalState(String message) {
    // The AI service now handles all sentiment analysis and emotional state updates
    // This method is kept for backward compatibility but doesn't need to do anything
    // as character.processUserMessage is called within the AI service
  }

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<Character>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                character.gender == Gender.male ? Icons.man : Icons.woman,
                color: Colors.blue.shade700,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('ChatMate', style: TextStyle(fontSize: 16)),
                  Text(
                    _getMoodCategoryText(character),
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            MoodIndicator(character: character, size: 24, showText: true),
          ],
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Nachrichtenverlauf',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: character,
                    child: MessageHistoryScreen(chatHistory: _chatHistory),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Mood bar at the top
          MoodBar(character: character),
          
          // Chat messages
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: MoodIndicator.getBackgroundGradient(character),
              ),
              child: ListenableBuilder(
                listenable: _chatHistory,
                builder: (context, _) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _chatHistory.messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _chatHistory.messages.length) {
                        // Typing indicator with mood-based styling
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Bubble(
                            margin: const BubbleEdges.only(top: 10),
                            alignment: Alignment.topLeft,
                            nip: BubbleNip.leftBottom,
                            color: MoodIndicator.getChatBubbleColor(character),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      _getTypingIndicatorColor(character)
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  _getTypingText(character),
                                  style: TextStyle(
                                    color: _getTypingIndicatorColor(character),
                                    fontStyle: character.isConfusedDistant || character.isBlockedDismissive 
                                        ? FontStyle.italic 
                                        : FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      final message = _chatHistory.messages[index];
                      final isUser = message.sender == MessageSender.user;
                      
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Bubble(
                          margin: const BubbleEdges.only(top: 10),
                          alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                          nip: isUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                          color: isUser ? Colors.blue.shade700 : MoodIndicator.getChatBubbleColor(character),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                              fontStyle: !isUser && (character.isConfusedDistant || character.isBlockedDismissive)
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          
          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Nachricht schreiben...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8.0),
                FloatingActionButton(
                  onPressed: _sendMessage,
                  backgroundColor: Colors.blue.shade700,
                  elevation: 0,
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
