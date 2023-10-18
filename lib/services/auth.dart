import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  // Instance
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Global variables
  static bool signedIn = false;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  void init() {
    if (_firebaseAuth.currentUser != null) {
      signedIn = true;
    }
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        signedIn = true;
      } else {
        signedIn = false;
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    Function? whenDone,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (whenDone != null) {
      whenDone();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
