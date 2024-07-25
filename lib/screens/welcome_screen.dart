import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage("assets/images/pattern.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.23),
                BlendMode.srcATop,
              ),
            ),
          ),
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                width: double.infinity,
                height: 430,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 35,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55),
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      "Enjoy the new experience of chatting with global friends",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(10),
                    Text(
                      "Connect people arround the world for free",
                      style: TextStyle(
                        color: Color.fromARGB(255, 170, 170, 170),
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Gap(30),
                    AuthButton(title: "Register"),
                    Gap(10),
                    AuthButton(title: "Login"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
