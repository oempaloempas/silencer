import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:silencer/services/auth.dart';

class LogInEmail extends StatefulWidget {
  const LogInEmail({super.key});

  @override
  State<LogInEmail> createState() => _LogInEmailState();
}

class _LogInEmailState extends State<LogInEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Voer je email in'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Voer een correct emailadres in';
                } else {
                  return null;
                }
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration:
                  const InputDecoration(hintText: 'Voer je wachtwoord in'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Voer een correct wachtwoord in';
                } else {
                  return null;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text;
                    String password = passwordController.text;
                    Auth().signInWithEmailAndPassword(
                      email: email,
                      password: password,
                      whenDone: () => context.go('/'),
                    );
                  }
                },
                child: const Text('Log in'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
