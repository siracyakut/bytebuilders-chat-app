import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/message_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/chat': (context) => const ChatScreen(),
        '/message': (context) => const MessageScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/loading': (context) => const LoadingScreen(),
      },
      initialRoute: '/loading',
    );
  }
}
