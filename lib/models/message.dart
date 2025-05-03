import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum MessageSender {
  user,
  character
}

enum MessageType {
  text,
  image
}

class Message {
  final String text;
  final DateTime timestamp;
  final MessageSender sender;
  final MessageType type;
  final String? imageUrl; // URL or path to the image
  
  Message({
    required this.text,
    required this.sender,
    this.type = MessageType.text,
    this.imageUrl,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
  
  // Factory constructor for text messages
  factory Message.text({
    required String text,
    required MessageSender sender,
    DateTime? timestamp,
  }) {
    return Message(
      text: text,
      sender: sender,
      type: MessageType.text,
      timestamp: timestamp,
    );
  }
  
  // Factory constructor for image messages
  factory Message.image({
    required String imageUrl,
    required MessageSender sender,
    String caption = '',
    DateTime? timestamp,
  }) {
    return Message(
      text: caption,
      sender: sender,
      type: MessageType.image,
      imageUrl: imageUrl,
      timestamp: timestamp,
    );
  }
  
  // Convert to and from JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'sender': sender.index,
      'type': type.index,
      'imageUrl': imageUrl,
    };
  }
  
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      sender: MessageSender.values[json['sender']],
      type: json.containsKey('type') 
          ? MessageType.values[json['type']] 
          : MessageType.text, // For backward compatibility
      imageUrl: json['imageUrl'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }
}

class ChatHistory with ChangeNotifier {
  final List<Message> _messages = [];
  String _chatId = DateTime.now().millisecondsSinceEpoch.toString();
  
  List<Message> get messages => List.unmodifiable(_messages);
  String get chatId => _chatId;
  
  void addMessage(Message message) {
    _messages.add(message);
    _saveMessages();
    notifyListeners();
  }
  
  void clear() {
    _messages.clear();
    _chatId = DateTime.now().millisecondsSinceEpoch.toString();
    _saveMessages();
    notifyListeners();
  }
  
  // Convert to and from JSON for persistence
  List<Map<String, dynamic>> toJson() {
    return _messages.map((message) => message.toJson()).toList();
  }
  
  void loadFromJson(List<dynamic> json) {
    _messages.clear();
    _messages.addAll(
      json.map((messageJson) => Message.fromJson(messageJson)).toList(),
    );
    notifyListeners();
  }
  
  // Save messages to local storage
  Future<void> _saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('chat_history_$_chatId', jsonEncode(toJson()));
      
      // Save chat ID to list of all chats
      final allChats = prefs.getStringList('all_chat_ids') ?? [];
      if (!allChats.contains(_chatId)) {
        allChats.add(_chatId);
        await prefs.setStringList('all_chat_ids', allChats);
      }
    } catch (e) {
      print('Error saving messages: $e');
    }
  }
  
  // Load messages from local storage
  Future<void> loadMessages(String chatId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final messagesString = prefs.getString('chat_history_$chatId');
      
      if (messagesString != null) {
        final messagesJson = jsonDecode(messagesString) as List;
        loadFromJson(messagesJson);
        _chatId = chatId;
      }
    } catch (e) {
      print('Error loading messages: $e');
    }
  }
  
  // Get all saved chat IDs
  static Future<List<String>> getAllChatIds() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList('all_chat_ids') ?? [];
    } catch (e) {
      print('Error getting all chat IDs: $e');
      return [];
    }
  }
}
