import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble/bubble.dart';
import '../../models/character.dart';
import '../../models/message.dart';
import '../../widgets/mood_indicator.dart';

class MessageHistoryScreen extends StatelessWidget {
  final ChatHistory chatHistory;
  
  const MessageHistoryScreen({
    super.key,
    required this.chatHistory,
  });

  @override
  Widget build(BuildContext context) {
    final character = Provider.of<Character>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nachrichtenverlauf'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Future feature: Filter messages by date, content, etc.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter-Funktion kommt bald!')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Date selector (for future implementation)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Heute',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Message list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: chatHistory.messages.length,
                itemBuilder: (context, index) {
                  final message = chatHistory.messages[index];
                  final isUser = message.sender == MessageSender.user;
                  
                  return Column(
                    crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      // Time stamp
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                          top: 16.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          _getTimeString(message.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      
                      // Message bubble
                      Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Bubble(
                          margin: const BubbleEdges.only(top: 4),
                          alignment: isUser ? Alignment.topRight : Alignment.topLeft,
                          nip: isUser ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                          color: isUser ? Colors.blue.shade700 : MoodIndicator.getChatBubbleColor(character),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            
            // Export button (for future implementation)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // Future feature: Export chat history
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export-Funktion kommt bald!')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Chat exportieren'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to format timestamp
  String _getTimeString(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    
    if (messageDate == today) {
      return 'Heute, ${_formatTime(timestamp)}';
    } else if (messageDate == today.subtract(const Duration(days: 1))) {
      return 'Gestern, ${_formatTime(timestamp)}';
    } else {
      return '${timestamp.day}.${timestamp.month}.${timestamp.year}, ${_formatTime(timestamp)}';
    }
  }
  
  // Helper method to format time
  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
