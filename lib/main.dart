import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/member_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Membership Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/memberList': (context) => MemberListScreen(),
      },
    );
  }
}


