//api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:5000/api";

  Future<List<dynamic>> fetchMembers() async {
    final response = await http.get(Uri.parse('$baseUrl/members'));
    return json.decode(response.body);
  }

  Future<void> addMember(Map<String, String> memberData) async {
    await http.post(
      Uri.parse('$baseUrl/members'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(memberData),
    );
  }
}
