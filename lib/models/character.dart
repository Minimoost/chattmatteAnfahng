import 'package:flutter/foundation.dart';

enum Gender { male, female }

enum AgeRange {
  young('18-25'),
  middleAged('26-35'),
  mature('36-50'),
  senior('50+');

  final String label;
  const AgeRange(this.label);
}

enum RelationshipStatus {
  justMet('Gerade kennengelernt'),
  acquaintance('Bekannte'),
  friends('Freunde'),
  closeFriends('Enge Freunde');

  final String label;
  const RelationshipStatus(this.label);
}

enum PersonalityType {
  shy('Schüchtern'),
  confident('Selbstbewusst'),
  humorous('Humorvoll'),
  thoughtful('Nachdenklich');

  final String label;
  const PersonalityType(this.label);
}

// Enhanced mood categories based on user's description
enum MoodCategory {
  neutralCurious('Neutral / Neugierig'),
  friendly('Freundschaftlich'),
  inLoveEmotional('Verliebt / Emotional'),
  confusedDistant('Verwirrt / Distanziert'),
  blockedDismissive('Blockiert / Abweisend');

  final String label;
  const MoodCategory(this.label);
}

class Character with ChangeNotifier {
  Gender gender;
  AgeRange ageRange;
  RelationshipStatus relationshipStatus;
  PersonalityType personalityType;
  bool isPremium = false;
  
  // Emotional state ranges from -100 (very negative) to 100 (very positive)
  int _emotionalState = 0;
  
  // Relationship points system (0-100)
  int _relationshipPoints = 50; // Start at neutral middle point
  
  // Trust level (0-100)
  int _trustLevel = 30; // Start with moderate trust based on relationship status
  
  // Conversation depth (0-100) - increases with meaningful conversations
  int _conversationDepth = 0;
  
  // Conversation count - tracks how many messages have been exchanged
  int _conversationCount = 0;
  
  // Flirt level (0-100) - tracks romantic interest
  int _flirtLevel = 0;
  
  // Current mood category
  MoodCategory _moodCategory = MoodCategory.neutralCurious;
  
  // Getters
  int get emotionalState => _emotionalState;
  int get relationshipPoints => _relationshipPoints;
  int get trustLevel => _trustLevel;
  int get conversationDepth => _conversationDepth;
  int get conversationCount => _conversationCount;
  int get flirtLevel => _flirtLevel;
  MoodCategory get moodCategory => _moodCategory;
  
  // Setters with notification
  set emotionalState(int value) {
    _emotionalState = value.clamp(-100, 100);
    _updateMoodCategory();
    notifyListeners();
  }
  
  set relationshipPoints(int value) {
    _relationshipPoints = value.clamp(0, 100);
    _updateMoodCategory();
    notifyListeners();
  }
  
  set trustLevel(int value) {
    _trustLevel = value.clamp(0, 100);
    notifyListeners();
  }
  
  set conversationDepth(int value) {
    _conversationDepth = value.clamp(0, 100);
    notifyListeners();
  }
  
  set flirtLevel(int value) {
    _flirtLevel = value.clamp(0, 100);
    notifyListeners();
  }
  
  // Increment conversation count
  void incrementConversationCount() {
    _conversationCount++;
    
    // Increase trust slightly with each conversation
    if (_conversationCount % 5 == 0 && _trustLevel < 100) {
      _trustLevel += 1;
    }
    
    // Increase conversation depth with more conversations
    if (_conversationCount % 10 == 0 && _conversationDepth < 100) {
      _conversationDepth += 2;
    }
    
    notifyListeners();
  }
  
  // Update mood category based on emotional state and relationship points
  void _updateMoodCategory() {
    if (_relationshipPoints < 20) {
      _moodCategory = MoodCategory.blockedDismissive;
    } else if (_relationshipPoints < 40) {
      _moodCategory = MoodCategory.confusedDistant;
    } else if (_relationshipPoints < 60) {
      _moodCategory = MoodCategory.neutralCurious;
    } else if (_relationshipPoints < 80) {
      _moodCategory = MoodCategory.friendly;
    } else {
      _moodCategory = MoodCategory.inLoveEmotional;
    }
    
    // Emotional state can override mood category in extreme cases
    if (_emotionalState < -70) {
      _moodCategory = MoodCategory.blockedDismissive;
    } else if (_emotionalState < -30) {
      _moodCategory = MoodCategory.confusedDistant;
    }
    
    notifyListeners();
  }
  
  // Getters for emotional state categories (for backward compatibility)
  bool get isDistant => _emotionalState < -50;
  bool get isNeutral => _emotionalState >= -50 && _emotionalState < 0;
  bool get isNice => _emotionalState >= 0 && _emotionalState < 50;
  bool get isInterested => _emotionalState >= 50;
  
  // New getters for mood categories
  bool get isNeutralCurious => _moodCategory == MoodCategory.neutralCurious;
  bool get isFriendly => _moodCategory == MoodCategory.friendly;
  bool get isInLoveEmotional => _moodCategory == MoodCategory.inLoveEmotional;
  bool get isConfusedDistant => _moodCategory == MoodCategory.confusedDistant;
  bool get isBlockedDismissive => _moodCategory == MoodCategory.blockedDismissive;
  
  Character({
    required this.gender,
    required this.ageRange,
    required this.relationshipStatus,
    required this.personalityType,
    this.isPremium = false,
    int initialEmotionalState = 0,
    int initialRelationshipPoints = 50,
    int initialTrustLevel = 30,
    int initialConversationDepth = 0,
    int initialFlirtLevel = 0,
  }) : 
    _emotionalState = initialEmotionalState.clamp(-100, 100),
    _relationshipPoints = initialRelationshipPoints.clamp(0, 100),
    _trustLevel = initialTrustLevel.clamp(0, 100),
    _conversationDepth = initialConversationDepth.clamp(0, 100),
    _flirtLevel = initialFlirtLevel.clamp(0, 100) {
      // Set initial relationship points based on relationship status
      switch (relationshipStatus) {
        case RelationshipStatus.justMet:
          _relationshipPoints = 40; // Neutral to slightly positive
          _trustLevel = 20;
          break;
        case RelationshipStatus.acquaintance:
          _relationshipPoints = 50; // Moderately positive
          _trustLevel = 30;
          break;
        case RelationshipStatus.friends:
          _relationshipPoints = 65; // Quite positive
          _trustLevel = 50;
          break;
        case RelationshipStatus.closeFriends:
          _relationshipPoints = 75; // Very positive
          _trustLevel = 70;
          break;
      }
      
      _updateMoodCategory();
  }
  
  // Method to update emotional state based on user interaction
  void updateEmotionalState(int change) {
    emotionalState += change;
    notifyListeners();
  }
  
  // Method to update relationship points based on user interaction
  void updateRelationshipPoints(int change) {
    relationshipPoints += change;
    notifyListeners();
  }
  
  // Method to update trust level based on user interaction
  void updateTrustLevel(int change) {
    trustLevel += change;
    notifyListeners();
  }
  
  // Method to update conversation depth based on user interaction
  void updateConversationDepth(int change) {
    conversationDepth += change;
    notifyListeners();
  }
  
  // Method to update flirt level based on user interaction
  void updateFlirtLevel(int change) {
    flirtLevel += change;
    notifyListeners();
  }
  
  // Method to process user message and update all relevant metrics
  void processUserMessage(String message, int sentimentScore) {
    // Update emotional state
    updateEmotionalState(sentimentScore);
    
    // Update relationship points (affected by sentiment but less volatile)
    updateRelationshipPoints((sentimentScore / 2).round());
    
    // Increment conversation count
    incrementConversationCount();
    
    // Update mood category
    _updateMoodCategory();
  }
  
  // Convert to and from JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'gender': gender.index,
      'ageRange': ageRange.index,
      'relationshipStatus': relationshipStatus.index,
      'personalityType': personalityType.index,
      'isPremium': isPremium,
      'emotionalState': _emotionalState,
      'relationshipPoints': _relationshipPoints,
      'trustLevel': _trustLevel,
      'conversationDepth': _conversationDepth,
      'conversationCount': _conversationCount,
      'flirtLevel': _flirtLevel,
      'moodCategory': _moodCategory.index,
    };
  }
  
  factory Character.fromJson(Map<String, dynamic> json) {
    final character = Character(
      gender: Gender.values[json['gender']],
      ageRange: AgeRange.values[json['ageRange']],
      relationshipStatus: RelationshipStatus.values[json['relationshipStatus']],
      personalityType: json.containsKey('personalityType') 
          ? PersonalityType.values[json['personalityType']]
          : PersonalityType.confident, // Default for backward compatibility
      isPremium: json['isPremium'] ?? false,
      initialEmotionalState: json['emotionalState'] ?? 0,
      initialRelationshipPoints: json['relationshipPoints'] ?? 50,
      initialTrustLevel: json['trustLevel'] ?? 30,
      initialConversationDepth: json['conversationDepth'] ?? 0,
      initialFlirtLevel: json['flirtLevel'] ?? 0,
    );
    
    // Set mood category if available
    if (json.containsKey('moodCategory')) {
      character._moodCategory = MoodCategory.values[json['moodCategory']];
    }
    
    return character;
  }
}
