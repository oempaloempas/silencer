

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _FirebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _FirebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _FirebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _FirebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}