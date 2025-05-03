import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/character.dart';
import '../chat_screen/chat_screen.dart';

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  Gender _selectedGender = Gender.female;
  AgeRange _selectedAgeRange = AgeRange.young;
  RelationshipStatus _selectedRelationshipStatus = RelationshipStatus.justMet;
  PersonalityType _selectedPersonalityType = PersonalityType.confident;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charakter erstellen'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wähle die Eigenschaften deines Chat-Partners:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              
              // Gender selection
              const Text(
                'Geschlecht:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildSelectionButton(
                      label: 'Mann',
                      isSelected: _selectedGender == Gender.male,
                      onTap: () => setState(() => _selectedGender = Gender.male),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildSelectionButton(
                      label: 'Frau',
                      isSelected: _selectedGender == Gender.female,
                      onTap: () => setState(() => _selectedGender = Gender.female),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Age range selection
              const Text(
                'Alter:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<AgeRange>(
                value: _selectedAgeRange,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                items: AgeRange.values.map((ageRange) {
                  return DropdownMenuItem<AgeRange>(
                    value: ageRange,
                    child: Text(ageRange.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedAgeRange = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              
              // Relationship status selection
              const Text(
                'Beziehungsstatus:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<RelationshipStatus>(
                value: _selectedRelationshipStatus,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                items: RelationshipStatus.values.map((status) {
                  return DropdownMenuItem<RelationshipStatus>(
                    value: status,
                    child: Text(status.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedRelationshipStatus = value);
                  }
                },
              ),
              
              const SizedBox(height: 24),
              
              // Personality type selection
              const Text(
                'Persönlichkeit:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<PersonalityType>(
                value: _selectedPersonalityType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                items: PersonalityType.values.map((personality) {
                  return DropdownMenuItem<PersonalityType>(
                    value: personality,
                    child: Text(personality.label),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedPersonalityType = value);
                  }
                },
              ),
              
              const SizedBox(height: 24),
              
              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final character = Character(
                      gender: _selectedGender,
                      ageRange: _selectedAgeRange,
                      relationshipStatus: _selectedRelationshipStatus,
                      personalityType: _selectedPersonalityType,
                    );
                    
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider.value(
                          value: character,
                          child: const ChatScreen(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Weiter'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildSelectionButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade700 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
