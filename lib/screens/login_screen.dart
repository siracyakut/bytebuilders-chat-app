// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/storage.dart';
import '../services/api.dart';
import '../utils/dialogs.dart';
import '../widgets/loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  loginUser() async {
    setState(() {
      loading = true;
    });

    Storage storage = Storage();
    API api = API();

    var data = await api.loginUserService(
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (data is DioException) {
      errorDialog(context: context, content: data.response?.data["data"]);
    } else {
      await storage.saveUser(
        username: data["data"]["email"],
        admin: data["data"]["admin"],
      );
      Navigator.of(context).pushNamedAndRemoveUntil("/chat", (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You are successfully logged in."),
          backgroundColor: Colors.green,
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingIndicator()
        : Scaffold(
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
                      height: 330,
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  "/welcome",
                                  (route) => false,
                                ),
                                child: const Icon(Icons.arrow_back, size: 30),
                              ),
                              const Text(
                                "Login to Your Account",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const Gap(30),
                          TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              hintText: "Username",
                            ),
                          ),
                          const Gap(10),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                          ),
                          const Gap(30),
                          ElevatedButton(
                            onPressed: () {
                              if (usernameController.text.trim().isEmpty ||
                                  passwordController.text.trim().isEmpty) {
                                errorDialog(
                                  context: context,
                                  content: "Please fill in the blanks.",
                                );
                              } else {
                                loginUser();
                              }
                            },
                            child: const Text("Login"),
                          ),
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
