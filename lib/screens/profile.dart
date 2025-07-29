import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String fullName;
  final String login;
  final String email;
  final String level;
  final String image;
  final String location;

  const ProfileScreen({
    super.key,
    required this.fullName,
    required this.login,
    required this.email,
    required this.level,
    required this.image,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return _buildProfileScreen();
  }

  Widget _buildProfileScreen() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 20),
          // Profile Image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 3),
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: ClipOval(
                child: Image.network(
                  image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.orange,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 60, color: Colors.grey);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // User Info
          Card(
            color: Colors.black,
            elevation: 10,
            shadowColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInfoRow('Full Name', fullName),
                  _buildInfoRow('Location', location),
                  _buildInfoRow('Login', login),
                  _buildInfoRow('Email', email),
                  _buildInfoRow('Level', level),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
