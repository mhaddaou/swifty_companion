import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Map<String, String>> projectsList;

  const ProjectsScreen({super.key, required this.projectsList});

  @override
  Widget build(BuildContext context) {
    return _buildProjectsScreen();
  }

  Widget _buildProjectsScreen() {
    return projectsList.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.work_outline, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No Projects',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'No projects found for this user',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        )
        : ListView.builder(
          itemCount: projectsList.length,
          itemBuilder: (context, index) {
            final project = projectsList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                decoration: BoxDecoration(

                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      
                        Text(project['name'] ?? '', style: TextStyle(color: Colors.white),),
                      Text(project['status'] ?? '', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Icon(Icons.star_border, color: Colors.orange,),
                        SizedBox(width: 20,),
                        Row(
                          children: [
                            Text('Final mark', style:TextStyle(color: Colors.white)),
                            Text('${project['final_mark']}', style:TextStyle(color: Colors.white),),

                          ],
                        )
                        // Text('Final mark ${project['final_mark']}', style: TextStyle(color: Colors.white))
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
  }
}
