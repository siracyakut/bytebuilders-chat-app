import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;

  const AuthButton({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              title == "Register" ? "/register" : "/login",
              (route) => false,
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              foregroundColor: Colors.white,
              elevation: 10,
              backgroundColor: const Color.fromRGBO(112, 62, 254, 1),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
