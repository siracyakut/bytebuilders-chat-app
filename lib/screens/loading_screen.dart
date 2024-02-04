// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../core/storage.dart';
import '../widgets/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Kullanicinin bu sayfaya erisimi yoksa welcomeScreen'e gonderiyoruz.
  getUser() async {
    Storage storage = Storage();

    var user = await storage.loadUser();

    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/welcome", (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil("/chat", (route) => false);
    }
  }

  // Screen'imiz yuklendiginde auth fonksiyonumuzu calistiriyoruz.
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingIndicator();
  }
}
