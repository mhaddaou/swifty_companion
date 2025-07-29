import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  final String skillData;

  const SkillsScreen({super.key, required this.skillData});

  @override
  Widget build(BuildContext context) {
    return _buildSkillsScreen();
  }

  Widget _buildSkillsScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, size: 100, color: Colors.orange),
          SizedBox(height: 20),
          Text(
            'Skills',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            skillData.isNotEmpty
                ? skillData
                : 'Skills and awards will be displayed here',
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
