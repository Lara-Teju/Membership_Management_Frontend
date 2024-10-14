import 'package:flutter/material.dart';

class MemberDetailScreen extends StatelessWidget {
  final Map<String, dynamic> member;

  MemberDetailScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Member Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${member['name']}", style: TextStyle(fontSize: 18)),
            Text("Email: ${member['email']}"),
            Text("Phone: ${member['phone']}"),
            Text("Preferences: ${member['preferences']}"),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}

