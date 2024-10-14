import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/api_service.dart';
import 'add_member_screen.dart';
import 'member_detail_screen.dart';

class MemberListScreen extends StatefulWidget {
  @override
  _MemberListScreenState createState() => _MemberListScreenState();
}

class _MemberListScreenState extends State<MemberListScreen> {
  final ApiService _apiService = ApiService();
  List<dynamic> _members = [];
  List<dynamic> _filteredMembers = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMembers();
    _startRefreshTimer();
    _searchController.addListener(_filterMembers);
  }

  void _startRefreshTimer() {
    Future.delayed(Duration(seconds: 10), () {
      _fetchMembers();
      _startRefreshTimer();
    });
  }

  Future<void> _fetchMembers() async {
    List<dynamic> members = await _apiService.fetchMembers();
    setState(() {
      _members = members;
      _filteredMembers = members;
    });
  }

  void _filterMembers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMembers = _members
          .where((member) =>
          member['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/auth/logout'),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          )
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search members by name...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredMembers.isEmpty
                ? Center(child: Text("No members found"))
                : ListView.builder(
              itemCount: _filteredMembers.length,
              itemBuilder: (context, index) {
                var member = _filteredMembers[index];
                return ListTile(
                  title: Text(member['name']),
                  subtitle: Text(member['email']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MemberDetailScreen(member: member),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddMemberScreen(),
            ),
          );
        },
      ),
    );
  }
}
