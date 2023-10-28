import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static Database? instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void init() {
    instance = this;
    // any additional initialization
  }
}
