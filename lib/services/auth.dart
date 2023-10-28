import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:silencer/firebase_options.dart';

class Auth {
  // Instance
  late FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Global variables
  static bool signedIn = false;
  String? userUID;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firebaseAuth = FirebaseAuth.instance;
    if (_firebaseAuth.currentUser != null) {
      signedIn = true;
    }
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        signedIn = true;
      } else {
        signedIn = false;
        userUID = null;
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    Function? whenDone,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (whenDone != null) {
      whenDone();
    }
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

  Future<UserCredential> signInWithGoogle() async {
    // Login when requested from a mobile device
    Future<UserCredential> signInMobile() async {
      // Letting the user log in
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Return the account info
      return await _firebaseAuth.signInWithCredential(credential);
    }

    // Login when requested from a web device
    Future<UserCredential> signInWeb() async {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      return await _firebaseAuth.signInWithPopup(googleProvider);
    }

    if (kIsWeb) {
      return signInWeb();
    } else {
      return signInMobile();
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
