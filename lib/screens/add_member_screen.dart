import 'package:flutter/material.dart';
import '../services/api_service.dart';  // Import your API service

class AddMemberScreen extends StatefulWidget {
  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _preferenceController = TextEditingController();
  final ApiService _apiService = ApiService();  // API service instance

  void _addMember() async {
    // Collect member data
    Map<String, String> memberData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'preferences': _preferenceController.text,
    };

    // Call API to add a new member
    await _apiService.addMember(memberData);

    // Navigate back to member list
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Member")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _preferenceController,
              decoration: InputDecoration(labelText: 'Preferences'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addMember,
              child: Text("Add Member"),
            ),
          ],
        ),
      ),
    );
  }
}
