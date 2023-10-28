import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silencer/services/auth.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welkom bij Silencer"),
        ),
        body: SizedBox.expand(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/signup'),
                  child: const Text("Sign up"),
                ),
                ElevatedButton(
                  onPressed: () => context.go('/login'),
                  child: const Text("Log in"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Auth().signInWithGoogle();
                  },
                  child: const Text("Sign in with Google"),
                )
              ]),
        ));
  }
}
