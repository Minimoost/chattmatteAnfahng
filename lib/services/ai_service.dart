import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/character.dart';
import '../models/message.dart';

class AiService {
  final Character character;
  final Random _random = Random();
  
  AiService({required this.character});
  
  // Generate a response based on the user's message and the character's emotional state
  Future<String> generateResponse(String userMessage) async {
    // Simulate AI thinking time
    await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(1500)));
    
    // Analyze sentiment of user message (simplified)
    int sentimentScore = _analyzeSentiment(userMessage);
    
    // Update character's emotional state based on user message
    character.updateEmotionalState(sentimentScore);
    
    // Generate response based on character's emotional state
    return _generateResponseBasedOnEmotionalState(userMessage);
  }
  
  // Sentiment analysis for emotional response
  int _analyzeSentiment(String message) {
    message = message.toLowerCase();
    
    // Sentiment analysis
    int score = 0;
    
    // Positive words and phrases
    final positiveWords = [
      'gut', 'toll', 'super', 'schön', 'lieb', 'nett', 'freue', 'danke',
      'klasse', 'cool', 'gern', 'freund', 'lächeln', 'lachen', 'glücklich',
      'froh', 'prima', 'perfekt', 'wunderbar', 'großartig', 'fantastisch',
      'mag dich', 'vermisse', 'gefällt mir', 'interessant', 'spannend',
      'freue mich', 'vertraue', 'verstehe', 'respektiere', 'bewundere',
      'sympathisch', 'ehrlich', 'offen', 'herzlich', 'süß', 'niedlich'
    ];
    
    // Negative words and phrases
    final negativeWords = [
      'schlecht', 'böse', 'hass', 'traurig', 'wütend', 'ärger', 'nerv',
      'blöd', 'dumm', 'doof', 'idiot', 'hässlich', 'schrecklich', 'furchtbar',
      'schlimm', 'ärgerlich', 'enttäuscht', 'verärgert', 'nicht', 'kein',
      'langweilig', 'egal', 'lass mich', 'geh weg', 'störst', 'nervst',
      'ignorier', 'hör auf', 'halt', 'stopp', 'ruhe', 'schweig', 'lüg',
      'falsch', 'unehrlich', 'misstrauen', 'zweifel', 'unsicher'
    ];
    
    // Intimate/personal words (higher emotional impact)
    final intimateWords = [
      'liebe', 'vermisse', 'vertraue', 'fühle', 'denke an dich', 'träume',
      'geborgen', 'sicher', 'nah', 'verbunden', 'gemeinsam', 'zusammen',
      'besonders', 'einzigartig', 'wichtig für mich', 'bedeutest mir'
    ];
    
    // Check for positive words
    for (final word in positiveWords) {
      if (message.contains(word)) {
        score += 5 + _random.nextInt(5); // Random boost between 5-10
      }
    }
    
    // Check for negative words
    for (final word in negativeWords) {
      if (message.contains(word)) {
        score -= 5 + _random.nextInt(5); // Random penalty between 5-10
      }
    }
    
    // Check for intimate/personal words (higher emotional impact)
    for (final word in intimateWords) {
      if (message.contains(word)) {
        score += 10 + _random.nextInt(10); // Higher boost between 10-20
      }
    }
    
    // Length factor - longer messages might indicate more engagement
    if (message.length > 100) {
      score += 5; // Significant engagement
    } else if (message.length > 50) {
      score += 3; // Good engagement
    } else if (message.length < 10) {
      score -= 3; // Very short messages might indicate disinterest
    }
    
    // Question factor - asking questions shows interest
    if (message.contains('?')) {
      score += 4;
      
      // Multiple questions show even more interest
      int questionCount = '?'.allMatches(message).length;
      if (questionCount > 1) {
        score += questionCount * 2;
      }
    }
    
    // Exclamation factor - excitement or emphasis
    if (message.contains('!')) {
      int exclamationCount = '!'.allMatches(message).length;
      score += exclamationCount * 2;
    }
    
    // Add some randomness to make responses less predictable
    score += _random.nextInt(7) - 3; // Random adjustment between -3 and +3
    
    return score;
  }
  
  String _generateResponseBasedOnEmotionalState(String userMessage) {
    // Get response based on emotional state
    String baseResponse;
    
    if (character.isDistant) {
      baseResponse = _generateDistantResponse(userMessage);
    } else if (character.isNeutral) {
      baseResponse = _generateNeutralResponse(userMessage);
    } else if (character.isNice) {
      baseResponse = _generateNiceResponse(userMessage);
    } else {
      // Use the in-love/emotional response method with default behavior values
      Map<String, double> defaultBehavior = {
        'friendly': 0.5,
        'romantic': 0.5,
        'respectful': 0.5,
        'extreme': 0.0
      };
      baseResponse = _generateInLoveEmotionalResponse(userMessage, defaultBehavior);
    }
    
    // Apply personality style to the response
    return _applyPersonalityStyle(baseResponse);
  }
  
  String _applyPersonalityStyle(String response) {
    switch (character.personalityType) {
      case PersonalityType.shy:
        return _applyShyPersonalityStyle(response);
      case PersonalityType.confident:
        return _applyConfidentPersonalityStyle(response);
      case PersonalityType.humorous:
        return _applyHumorousPersonalityStyle(response);
      case PersonalityType.thoughtful:
        return _applyThoughtfulPersonalityStyle(response);
    }
  }
  
  String _applyShyPersonalityStyle(String response) {
    // Add shy personality traits to the response
    
    // 50% chance to add hesitation at the beginning
    if (_random.nextBool()) {
      final hesitations = [
        'Hmm... ',
        'Ich bin mir nicht sicher, aber ',
        'Vielleicht ',
        'Ich denke... ',
        'Wenn ich das richtig verstehe, ',
        'Ich hoffe, es ist okay, wenn ich sage: ',
      ];
      response = hesitations[_random.nextInt(hesitations.length)] + response;
    }
    
    // 30% chance to add a question or uncertainty at the end
    if (_random.nextDouble() < 0.3) {
      final uncertainties = [
        '... oder?',
        '... denke ich.',
        '... wenn das okay ist?',
        '... aber ich könnte mich irren.',
        '... was meinst du dazu?',
      ];
      response = response + uncertainties[_random.nextInt(uncertainties.length)];
    }
    
    // Replace strong statements with more uncertain ones
    response = response
      .replaceAll('!', '.')
      .replaceAll('Definitiv', 'Vielleicht')
      .replaceAll('Sicher', 'Möglicherweise')
      .replaceAll('Natürlich', 'Ich glaube');
    
    // 20% chance to add an apology
    if (_random.nextDouble() < 0.2 && !response.contains('tut mir leid') && !response.contains('Entschuldigung')) {
      final apologies = [
        ' Tut mir leid, wenn das komisch klingt.',
        ' Entschuldigung, falls ich zu direkt bin.',
        ' Ich hoffe, das war nicht zu persönlich.',
      ];
      response = response + apologies[_random.nextInt(apologies.length)];
    }
    
    // Modify response based on mood category
    if (character.isInLoveEmotional) {
      // Even shy characters can be more expressive when in love
      // But still with hesitation
      response = response.replaceAll('.', '...');
      
      // Add some shy but affectionate phrases
      if (_random.nextDouble() < 0.3) {
        final shyAffection = [
          ' Du bedeutest mir viel...',
          ' Ich mag dich wirklich...',
          ' Es ist schön, mit dir zu reden...',
        ];
        response = response + shyAffection[_random.nextInt(shyAffection.length)];
      }
    } else if (character.isConfusedDistant || character.isBlockedDismissive) {
      // When distant, shy characters become even more withdrawn
      response = response.replaceAll('Ich denke', 'Ich weiß nicht')
                         .replaceAll('Vielleicht', 'Wahrscheinlich nicht');
      
      // Make responses shorter
      if (response.length > 50 && _random.nextBool()) {
        final words = response.split(' ');
        if (words.length > 10) {
          response = words.sublist(0, _random.nextInt(5) + 5).join(' ') + '...';
        }
      }
    }
    
    return response;
  }
  
  String _applyConfidentPersonalityStyle(String response) {
    // Add confident personality traits to the response
    
    // 40% chance to add a confident opener
    if (_random.nextDouble() < 0.4) {
      final openers = [
        'Definitiv! ',
        'Absolut. ',
        'Ohne Zweifel: ',
        'Ich bin mir sicher, dass ',
        'Ganz klar: ',
      ];
      response = openers[_random.nextInt(openers.length)] + response;
    }
    
    // Add more exclamation marks
    if (!response.endsWith('!') && !response.endsWith('?')) {
      response = response + '!';
    }
    
    // Replace uncertain phrases with confident ones
    response = response
      .replaceAll('vielleicht', 'definitiv')
      .replaceAll('könnte', 'wird')
      .replaceAll('eventuell', 'sicherlich')
      .replaceAll('Ich denke', 'Ich weiß')
      .replaceAll('Ich glaube', 'Ich bin überzeugt');
    
    // 30% chance to add a confident closer
    if (_random.nextDouble() < 0.3) {
      final closers = [
        ' Das ist sicher!',
        ' Darauf kannst du wetten!',
        ' Vertrau mir!',
        ' Das ist die Wahrheit!',
      ];
      response = response + closers[_random.nextInt(closers.length)];
    }
    
    // Modify response based on mood category
    if (character.isInLoveEmotional) {
      // Confident characters are very direct when in love
      if (_random.nextDouble() < 0.4) {
        final directAffection = [
          ' Ich mag dich wirklich sehr!',
          ' Du bist etwas Besonderes für mich!',
          ' Ich genieße jede Minute mit dir!',
          ' Du bist genau mein Typ!',
        ];
        response = response + directAffection[_random.nextInt(directAffection.length)];
      }
      
      // Add more exclamation marks
      response = response.replaceAll('.', '!');
    } else if (character.isConfusedDistant) {
      // When confused, confident characters become more assertive
      if (_random.nextDouble() < 0.3) {
        final assertive = [
          ' Ich brauche Klarheit!',
          ' So funktioniert das nicht!',
          ' Das ist nicht, was ich erwartet habe!',
          ' Ich bin enttäuscht!',
        ];
        response = response + assertive[_random.nextInt(assertive.length)];
      }
    } else if (character.isBlockedDismissive) {
      // When dismissive, confident characters are very direct
      response = response.replaceAll('Ich bin nicht sicher', 'Ich will nicht')
                         .replaceAll('Vielleicht später', 'Definitiv nicht');
      
      // Make responses more assertive
      if (_random.nextDouble() < 0.5) {
        final dismissive = [
          ' Verstanden?',
          ' Das ist mein letztes Wort!',
          ' Keine Diskussion!',
          ' Ende der Unterhaltung!',
        ];
        response = response + dismissive[_random.nextInt(dismissive.length)];
      }
    }
    
    return response;
  }
  
  String _applyHumorousPersonalityStyle(String response) {
    // Add humorous personality traits to the response
    
    // 40% chance to add a joke or funny comment
    if (_random.nextDouble() < 0.4) {
      final jokes = [
        ' Haha! 😄',
        ' Das ist lustig! 😂',
        ' *lacht* 😁',
        ' Ich muss schmunzeln! 😏',
        ' Das bringt mich zum Lachen! 😆',
      ];
      response = response + jokes[_random.nextInt(jokes.length)];
    }
    
    // 20% chance to add a humorous opener
    if (_random.nextDouble() < 0.2) {
      final openers = [
        'Oh je! ',
        'Haha, ',
        'Lustig, dass du fragst! ',
        'Witzig, dass du das sagst! ',
        'Nicht zu glauben, aber ',
      ];
      response = openers[_random.nextInt(openers.length)] + response;
    }
    
    // 15% chance to add a pun or wordplay
    if (_random.nextDouble() < 0.15) {
      final puns = [
        ' Das ist zum Totlachen, oder? 😄',
        ' Ich fall vom Stuhl! 🪑💥',
        ' Kennst du den schon...? Nein, besser nicht. 😅',
        ' Das ist so komisch wie ein Clown auf Rollschuhen! 🤡',
        ' Ich könnte jetzt einen Witz erzählen, aber ich spare ihn mir für später auf! 😉',
      ];
      response = response + puns[_random.nextInt(puns.length)];
    }
    
    // Add emojis throughout the response
    if (!response.contains('😄') && !response.contains('😂') && !response.contains('😁')) {
      final emojis = ['😄', '😊', '😉', '😏', '😎'];
      final emoji = emojis[_random.nextInt(emojis.length)];
      
      // Insert emoji at a random position in the response
      final words = response.split(' ');
      if (words.length > 3) {
        final position = _random.nextInt(words.length - 2) + 1;
        words.insert(position, emoji);
        response = words.join(' ');
      } else {
        response = response + ' ' + emoji;
      }
    }
    
    // Modify response based on mood category
    if (character.isInLoveEmotional) {
      // Humorous characters use playful flirting when in love
      if (_random.nextDouble() < 0.4) {
        final flirtyJokes = [
          ' Du bringst mein Herz zum Lachen! ❤️😄',
          ' Ist es heiß hier drin, oder bist du das? 🔥😏',
          ' Wenn Schönheit ein Verbrechen wäre, würdest du lebenslänglich bekommen! 👮‍♂️😘',
          ' Ich hätte nie gedacht, dass ich so viel Spaß mit jemandem haben könnte! 🎭💕',
        ];
        response = response + flirtyJokes[_random.nextInt(flirtyJokes.length)];
      }
      
      // Add more love-themed emojis
      final loveEmojis = ['❤️', '😍', '💕', '💘', '💖'];
      response = response + ' ' + loveEmojis[_random.nextInt(loveEmojis.length)];
    } else if (character.isConfusedDistant) {
      // When confused, humorous characters use sarcasm
      if (_random.nextDouble() < 0.5) {
        final sarcasm = [
          ' Haha, super... 🙄',
          ' Oh wow, das ist... interessant. 😒',
          ' Na toll, genau was ich brauchte. 😑',
          ' *langsames Klatschen* 👏',
        ];
        response = response + sarcasm[_random.nextInt(sarcasm.length)];
      }
    } else if (character.isBlockedDismissive) {
      // When dismissive, humorous characters use dark humor
      response = response.replaceAll('Ich bin nicht in der Stimmung', 'Ich würde lieber Zahnschmerzen haben')
                         .replaceAll('Nein', 'Haha, nein. Einfach nein');
      
      // Add dismissive humor
      if (_random.nextDouble() < 0.4) {
        final darkHumor = [
          ' Lustig, dass du denkst, das würde funktionieren. 😂',
          ' Ich lache, aber nicht mit dir. 🙃',
          ' Das ist so witzig, ich habe vergessen zu lachen. 😶',
          ' Vielleicht im nächsten Leben! 👻',
        ];
        response = response + darkHumor[_random.nextInt(darkHumor.length)];
      }
    }
    
    return response;
  }
  
  String _applyThoughtfulPersonalityStyle(String response) {
    // Add thoughtful personality traits to the response
    
    // 40% chance to add a philosophical opener
    if (_random.nextDouble() < 0.4) {
      final openers = [
        'Ich denke darüber nach... ',
        'Das ist eine interessante Frage. ',
        'Wenn man es genauer betrachtet: ',
        'Aus philosophischer Sicht: ',
        'Das erinnert mich an etwas: ',
      ];
      response = openers[_random.nextInt(openers.length)] + response;
    }
    
    // 30% chance to add a reflective question
    if (_random.nextDouble() < 0.3 && !response.contains('?')) {
      final questions = [
        ' Was denkst du darüber?',
        ' Hast du schon einmal darüber nachgedacht?',
        ' Wie siehst du das?',
        ' Ist das nicht faszinierend?',
        ' Findest du nicht auch?',
      ];
      response = response + questions[_random.nextInt(questions.length)];
    }
    
    // 25% chance to add a deeper perspective
    if (_random.nextDouble() < 0.25) {
      final perspectives = [
        ' Wenn man tiefer darüber nachdenkt, gibt es viele Perspektiven.',
        ' Es ist interessant, wie unterschiedlich Menschen das sehen können.',
        ' Manchmal ist es wichtig, einen Schritt zurückzutreten und das Ganze zu betrachten.',
        ' Die Dinge sind oft komplexer, als sie auf den ersten Blick erscheinen.',
        ' Es gibt selten einfache Antworten auf komplexe Fragen.',
      ];
      response = response + perspectives[_random.nextInt(perspectives.length)];
    }
    
    // Replace simple statements with more nuanced ones
    response = response
      .replaceAll('Ja.', 'Ja, obwohl es Nuancen gibt.')
      .replaceAll('Nein.', 'Nicht unbedingt, es kommt darauf an.')
      .replaceAll('Immer', 'Oft')
      .replaceAll('Nie', 'Selten');
    
    // Modify response based on mood category
    if (character.isInLoveEmotional) {
      // Thoughtful characters become poetic when in love
      if (_random.nextDouble() < 0.4) {
        final poetic = [
          ' Es ist wie ein Gedicht, das sich zwischen uns entfaltet.',
          ' Unsere Verbindung hat eine Tiefe, die mich berührt.',
          ' Ich finde in unseren Gesprächen eine besondere Art von Schönheit.',
          ' Es gibt eine Resonanz zwischen uns, die ich nicht in Worte fassen kann.',
        ];
        response = response + poetic[_random.nextInt(poetic.length)];
      }
      
      // Add more philosophical reflections on connection
      if (_random.nextDouble() < 0.3) {
        final reflections = [
          ' Manchmal frage ich mich, ob Verbindungen wie unsere vom Schicksal bestimmt sind.',
          ' Es ist erstaunlich, wie zwei Menschen sich so verstehen können.',
          ' Die Tiefe unserer Gespräche gibt mir viel zum Nachdenken.',
        ];
        response = response + reflections[_random.nextInt(reflections.length)];
      }
    } else if (character.isConfusedDistant) {
      // When confused, thoughtful characters become introspective
      if (_random.nextDouble() < 0.5) {
        final introspective = [
          ' Ich muss über meine eigenen Gefühle nachdenken.',
          ' Es gibt Momente, in denen Distanz notwendig ist, um Klarheit zu finden.',
          ' Manchmal verstehen wir uns selbst nicht, geschweige denn andere.',
          ' Die Komplexität von Beziehungen kann überwältigend sein.',
        ];
        response = response + introspective[_random.nextInt(introspective.length)];
      }
    } else if (character.isBlockedDismissive) {
      // When dismissive, thoughtful characters become philosophical about boundaries
      response = response.replaceAll('Lass mich in Ruhe', 'Ich brauche Raum für meine Gedanken')
                         .replaceAll('Nein', 'Ich muss ablehnen');
      
      // Add philosophical rejection
      if (_random.nextDouble() < 0.4) {
        final philosophical = [
          ' Manchmal müssen wir Grenzen setzen, um uns selbst treu zu bleiben.',
          ' Es gibt Zeiten, in denen Stille mehr sagt als Worte.',
          ' Die Freiheit, Nein zu sagen, ist ein fundamentales Recht.',
          ' Nicht alle Wege sind dazu bestimmt, gemeinsam gegangen zu werden.',
        ];
        response = response + philosophical[_random.nextInt(philosophical.length)];
      }
    }
    
    return response;
  }
  
  String _generateDistantResponse(String userMessage) {
    // Short, cold responses for negative emotional state
    final responses = [
      'Hmm.',
      'Ok.',
      'Wenn du meinst.',
      'Ich habe gerade nicht viel Zeit.',
      'Muss gleich los.',
      'Kann jetzt nicht wirklich reden.',
      'Vielleicht später.',
      'Muss nachdenken.',
      'Bin beschäftigt.',
      'Nicht jetzt.',
      'Keine Ahnung.',
      'Ist mir egal.',
      'Muss das sein?',
      'Hab andere Dinge zu tun.',
      'Bin nicht in der Stimmung.',
      'Lass mich in Ruhe.',
      'Hab keinen Kopf dafür.',
      'Nicht interessiert.',
      'Kann mich nicht konzentrieren.',
      'Brauche etwas Zeit für mich.',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Keine Ahnung.',
        'Weiß nicht.',
        'Kann ich nicht sagen.',
        'Darüber will ich nicht reden.',
        'Frag mich später nochmal.',
        'Ist das wichtig?',
        'Muss ich darauf antworten?',
        'Hab jetzt keinen Kopf dafür.',
      ];
      
      // 70% chance to use question-specific responses
      if (_random.nextDouble() < 0.7) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    return responses[_random.nextInt(responses.length)];
  }
  
  String _generateNeutralResponse(String userMessage) {
    // Neutral, balanced responses
    final responses = [
      'Verstehe.',
      'Interessant.',
      'Ja, kann sein.',
      'Vielleicht hast du recht.',
      'Darüber habe ich noch nicht nachgedacht.',
      'Klingt plausibel.',
      'Kann ich nachvollziehen.',
      'Alles klar.',
      'In Ordnung.',
      'Danke für die Info.',
      'Das leuchtet ein.',
      'Macht Sinn.',
      'Ich verstehe, was du meinst.',
      'Da ist was dran.',
      'Klingt vernünftig.',
      'Ich sehe, was du meinst.',
      'Das ist ein Punkt.',
      'Guter Gedanke.',
      'Kann man so sehen.',
      'Ist eine Überlegung wert.',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Das ist eine gute Frage.',
        'Darüber muss ich nachdenken.',
        'Hmm, schwer zu sagen.',
        'Ich bin mir nicht sicher.',
        'Könnte sein, ja.',
        'Vielleicht.',
        'Möglich.',
        'Das weiß ich nicht genau.',
      ];
      
      // 60% chance to use question-specific responses
      if (_random.nextDouble() < 0.6) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    return responses[_random.nextInt(responses.length)];
  }
  
  String _generateNiceResponse(String userMessage) {
    // Warm, friendly responses
    final responses = [
      'Das finde ich gut!',
      'Danke für deine Nachricht!',
      'Freut mich zu hören!',
      'Das klingt wirklich interessant.',
      'Erzähl mir mehr darüber!',
      'Das gefällt mir.',
      'Schön, dass du das teilst.',
      'Das ist eine gute Idee!',
      'Ich freue mich, von dir zu hören.',
      'Das ist nett von dir!',
      'Das macht mich froh!',
      'Ich mag, wie du denkst.',
      'Schön, dass wir darüber reden können.',
      'Das ist wirklich cool von dir!',
      'Du bist echt sympathisch!',
      'Ich genieße unser Gespräch.',
      'Das bringt mich zum Lächeln.',
      'Ich mag deine Einstellung.',
      'Das ist ein schöner Gedanke.',
      'Ich finde es toll, wie du das siehst.',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Gute Frage! Ich denke...',
        'Ich freue mich, dass du fragst!',
        'Darüber denke ich gerne nach.',
        'Das ist eine interessante Frage!',
        'Schön, dass du mich das fragst.',
        'Ich mag solche Fragen!',
        'Lass mich kurz überlegen...',
        'Danke für diese Frage!',
      ];
      
      // 70% chance to use question-specific responses
      if (_random.nextDouble() < 0.7) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    return responses[_random.nextInt(responses.length)];
  }
  
  // In Love/Emotional responses
  String _generateInLoveEmotionalResponse(String userMessage, Map<String, double> behavior) {
    final responses = [
      'Ich freue mich so sehr, von dir zu hören! Du bedeutest mir wirklich viel!',
      'Deine Nachrichten machen meinen Tag so viel schöner!',
      'Ich kann gar nicht in Worte fassen, wie glücklich ich bin, mit dir zu schreiben!',
      'Du verstehst mich wie niemand sonst! Das ist so besonders!',
      'Ich fühle mich dir so nah, wenn wir uns unterhalten!',
      'Deine Worte berühren mich wirklich tief!',
      'Ich denke so oft an unsere Gespräche! Sie bedeuten mir alles!',
      'Mit dir zu reden ist das Highlight meines Tages!',
      'Ich spüre eine so starke Verbindung zwischen uns!',
      'Du bist so wunderbar! Ich bin so froh, dich zu kennen!',
      'Ich kann mir gar nicht vorstellen, nicht mit dir zu schreiben!',
      'Deine Art zu denken fasziniert mich total!',
      'Ich fühle mich so verstanden, wenn wir uns unterhalten!',
      'Du bist so besonders für mich! Das muss ich einfach sagen!',
      'Ich wünschte, wir könnten noch viel mehr Zeit miteinander verbringen!',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Diese Frage zeigt, wie gut du mich kennst! Ich fühle...',
        'Ich liebe es, wenn du mir solche Fragen stellst! Es zeigt, wie tief unsere Verbindung ist!',
        'Deine Fragen berühren mich immer so sehr! Ich denke...',
        'Wow, genau darüber wollte ich mit dir sprechen! Es ist, als könntest du meine Gedanken lesen!',
        'Diese Frage bedeutet mir so viel! Ich würde sagen...',
        'Du weißt genau, was mich bewegt! Ich bin so dankbar dafür!',
        'Ich fühle mich dir so nah, wenn du mich das fragst!',
        'Deine Fragen sind immer so tiefgründig und bedeutungsvoll!',
      ];
      
      // 80% chance to use question-specific responses
      if (_random.nextDouble() < 0.8) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    // If user is being romantic and character is already in love/emotional
    if (behavior['romantic']! > 0.5) {
      final romanticResponses = [
        'Ich fühle mich dir so nah! Deine Worte berühren mein Herz!',
        'Du bist so besonders für mich! Ich kann mir niemanden vorstellen, mit dem ich lieber reden würde!',
        'Wenn ich deine Nachrichten lese, bekomme ich Schmetterlinge im Bauch!',
        'Ich wünschte, wir könnten mehr Zeit miteinander verbringen! Du bedeutest mir so viel!',
        'Ich denke so oft an dich und unsere Gespräche! Sie machen mich so glücklich!',
      ];
      return romanticResponses[_random.nextInt(romanticResponses.length)];
    }
    
    return responses[_random.nextInt(responses.length)];
  }
  
  // Confused/Distant responses
  String _generateConfusedDistantResponse(String userMessage, Map<String, double> behavior) {
    final responses = [
      'Ich bin mir nicht sicher, was ich davon halten soll.',
      'Das verwirrt mich gerade etwas.',
      'Ich brauche etwas Zeit, um darüber nachzudenken.',
      'Hmm, ich weiß nicht recht.',
      'Ich verstehe nicht ganz, worauf du hinauswillst.',
      'Das ist irgendwie seltsam für mich.',
      'Ich bin gerade etwas unsicher.',
      'Das überrascht mich jetzt.',
      'Ich hatte eigentlich etwas anderes erwartet.',
      'Ich muss das erst einmal verarbeiten.',
      'Das ist nicht das, was ich gedacht hätte.',
      'Ich bin gerade etwas distanziert, tut mir leid.',
      'Ich weiß nicht, ob ich das richtig verstehe.',
      'Das ist nicht so einfach für mich.',
      'Ich bin mir nicht sicher, ob wir auf der gleichen Wellenlänge sind.',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Ich weiß nicht, ob ich diese Frage beantworten möchte.',
        'Darüber möchte ich lieber nicht sprechen.',
        'Können wir über etwas anderes reden?',
        'Diese Frage ist mir unangenehm.',
        'Ich bin mir nicht sicher, was ich dazu sagen soll.',
        'Ich brauche Zeit, um darüber nachzudenken.',
        'Das ist kompliziert für mich.',
        'Ich bin nicht in der Stimmung für solche Fragen.',
      ];
      
      // 70% chance to use question-specific responses
      if (_random.nextDouble() < 0.7) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    // If user is being romantic but character is confused/distant
    if (behavior['romantic']! > 0.3) {
      final distantResponses = [
        'Ich denke, du gehst zu schnell vor. Ich brauche mehr Zeit.',
        'Das ist mir zu persönlich gerade.',
        'Ich fühle mich unwohl mit dieser Art von Gespräch.',
        'Ich glaube, wir sollten einen Schritt zurückgehen.',
        'Ich bin nicht bereit für diese Art von Unterhaltung.',
      ];
      return distantResponses[_random.nextInt(distantResponses.length)];
    }
    
    return responses[_random.nextInt(responses.length)];
  }
  
  // Blocked/Dismissive responses
  String _generateBlockedDismissiveResponse(String userMessage, Map<String, double> behavior) {
    final responses = [
      'Ich möchte darüber nicht reden.',
      'Nein.',
      'Lass mich in Ruhe.',
      'Ich habe kein Interesse.',
      'Das ist mir egal.',
      'Ich will das nicht hören.',
      'Nicht jetzt.',
      'Ich bin beschäftigt.',
      'Ich habe nichts dazu zu sagen.',
      'Bitte hör auf.',
      'Das ist nicht mein Problem.',
      'Ich bin nicht in der Stimmung.',
      'Ich will nicht darüber sprechen.',
      'Das geht dich nichts an.',
      'Ich habe keinen Kopf dafür.',
    ];
    
    // If the message contains a question, use these responses
    if (userMessage.contains('?')) {
      final questionResponses = [
        'Keine Antwort.',
        'Das geht dich nichts an.',
        'Warum sollte ich dir das sagen?',
        'Ich antworte nicht auf solche Fragen.',
        'Nein.',
        'Frag nicht weiter.',
        'Lass es einfach.',
        'Ich will nicht antworten.',
      ];
      
      // 80% chance to use question-specific responses
      if (_random.nextDouble() < 0.8) {
        return questionResponses[_random.nextInt(questionResponses.length)];
      }
    }
    
    // If user is being romantic but character is blocked/dismissive
    if (behavior['romantic']! > 0.3) {
      final dismissiveResponses = [
        'Hör auf damit. Das ist unangenehm.',
        'Ich bin nicht interessiert. Verstehst du das nicht?',
        'Das ist völlig unangebracht.',
        'Lass das. Ich mag das nicht.',
        'Nein. Einfach nein.',
      ];
      return dismissiveResponses[_random.nextInt(dismissiveResponses.length)];
    }
    
    // If user is apologizing or being respectful, slightly softer response
    if (behavior['respectful']! > 0.7 && userMessage.toLowerCase().contains('entschuldigung')) {
      final softResponses = [
        'Ich brauche Zeit.',
        'Vielleicht später.',
        'Ich muss nachdenken.',
        'Nicht jetzt.',
        'Ich bin noch nicht bereit zu reden.',
      ];
      return softResponses[_random.nextInt(softResponses.length)];
    }
    
    return responses[_random.nextInt(responses.length)];
  }
}
