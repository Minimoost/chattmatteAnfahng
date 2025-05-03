import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';
import '../models/message.dart';

class StorageService {
  static const String _characterKey = 'character';
  static const String _messagesKey = 'messages';
  
  Future<void> saveCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    final characterJson = jsonEncode(character.toJson());
    await prefs.setString(_characterKey, characterJson);
  }
  
  Future<Character?> loadCharacter() async {
    final prefs = await SharedPreferences.getInstance();
    final characterJson = prefs.getString(_characterKey);
    
    if (characterJson == null) {
      return null;
    }
    
    try {
      final Map<String, dynamic> json = jsonDecode(characterJson);
      return Character.fromJson(json);
    } catch (e) {
      print('Error loading character: $e');
      return null;
    }
  }
  
  Future<void> saveMessages(ChatHistory chatHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = jsonEncode(chatHistory.toJson());
    await prefs.setString(_messagesKey, messagesJson);
  }
  
  Future<void> loadMessages(ChatHistory chatHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getString(_messagesKey);
    
    if (messagesJson == null) {
      return;
    }
    
    try {
      final List<dynamic> json = jsonDecode(messagesJson);
      chatHistory.loadFromJson(json);
    } catch (e) {
      print('Error loading messages: $e');
    }
  }
  
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
