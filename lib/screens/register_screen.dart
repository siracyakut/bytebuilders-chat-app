// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../core/storage.dart';
import '../services/api.dart';
import '../utils/dialogs.dart';
import '../widgets/loading_indicator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();

  registerUser() async {
    setState(() {
      loading = true;
    });

    Storage storage = Storage();
    API api = API();

    var data = await api.registerUserService(
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
          content: Text("You are successfully signed up."),
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
                      height: 341,
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
                                "Register to Chat App",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          const Gap(10),
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
                          const Gap(10),
                          TextField(
                            controller: passwordConfirmController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                            ),
                          ),
                          const Gap(15),
                          ElevatedButton(
                            onPressed: () {
                              if (passwordController.text !=
                                  passwordConfirmController.text) {
                                errorDialog(
                                  context: context,
                                  content: "Passwords not match!",
                                );
                              } else if (usernameController.text
                                      .trim()
                                      .isEmpty ||
                                  passwordController.text.trim().isEmpty ||
                                  passwordConfirmController.text
                                      .trim()
                                      .isEmpty) {
                                errorDialog(
                                  context: context,
                                  content: "Please fill in the blanks.",
                                );
                              } else {
                                registerUser();
                              }
                            },
                            child: const Text("Register"),
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
