import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const FRCTeamHelperApp());
}

class FRCTeamHelperApp extends StatelessWidget {
  const FRCTeamHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
