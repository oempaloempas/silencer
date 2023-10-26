import 'package:flutter/material.dart';
import 'package:silencer/services/soundmode.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Soundmode.ringPermissionGranted();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
