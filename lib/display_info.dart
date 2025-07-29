import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:swifty_companion/screens/profile.dart';
import 'package:swifty_companion/screens/projects.dart';
import 'package:swifty_companion/screens/skills.dart';

class DisplayInfo extends StatefulWidget {
  final Map<String, dynamic> userData;
  const DisplayInfo({super.key, required this.userData});

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  int _currentIndex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _processUserData();
  }

  void _processUserData() {
    try {
      fullName = widget.userData['usual_full_name'] ?? "";
      image = widget.userData['image']['link'] ?? "";
      login = widget.userData['login'] ?? "";
      email = widget.userData['email'] ?? "";
      level = widget.userData['cursus_users']?[1]?['level']?.toString() ?? "0";
      location = widget.userData['location'] ?? "Unavailable";
      List<dynamic> projectsUsers = List<dynamic>.from(
        widget.userData['projects_users'] ?? [],
      );
      projectsUsers.forEach((project) {
        if (project != null) {
          final String name = project['project']['name'] ?? "";
          final dynamic final_mark = project['final_mark'].toString();
          final String status = project['status'] ?? "";
          final String validated = project['validated?'].toString();
          projectsList.add({
            'name': name,
            'final_mark': final_mark,
            'status': status,
            'validated' : validated
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  String fullName = '';
  String image = '';
  String login = '';
  String email = '';
  String level = '';
  String location = "";
  List<Map<String, String>> projectsList = [];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(_getTitle(), style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.orange,
          ),
        ),
        body: _buildCurrentScreen(),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _currentIndex,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.person, size: 30, color: Colors.white),
            Icon(Icons.work, size: 30, color: Colors.white),
            Icon(Icons.star, size: 30, color: Colors.white),
          ],
          color: Colors.orange,
          buttonBackgroundColor: Colors.orange,
          backgroundColor: Colors.black,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return 'Profile';
      case 1:
        return 'Projects';
      case 2:
        return 'Skills';
      default:
        return 'Profile';
    }
  }

  Widget _buildCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return ProfileScreen(
          email: email,
          fullName: fullName,
          image: image,
          level: level,
          login: login,
          location: location,
        );
      case 1:
        return ProjectsScreen(projectsList: projectsList);
      case 2:
        return SkillsScreen(skillData: fullName);
      default:
        return ProfileScreen(
          email: email,
          fullName: fullName,
          image: image,
          level: level,
          location: location,
          login: login,
        );
    }
  }
}
