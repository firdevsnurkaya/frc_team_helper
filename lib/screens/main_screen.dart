import 'package:flutter/material.dart';
import '../models/help_request.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  String myTeam = "";

  List<HelpRequest> requests = [
    HelpRequest(
      teamNumber: "1234",
      branch: "Yazılım",
      description: "Limelight çalışmıyor",
      urgency: "acil",
    ),
  ];

  void completeHelp(HelpRequest request) {
    setState(() {
      request.completed = true;
      request.completedBy = myTeam;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      // ✅ HOME SCREEN KULLANIMI TAM HALİ
      HomeScreen(
        requests: requests,
        onComplete: completeHelp,
        onAdd: (request) {
          setState(() {
            requests.add(request);
          });
        },
      ),

      // ✅ PROFILE SCREEN
      ProfileScreen(
        onSave: (team) {
          setState(() {
            myTeam = team;
          });
        },
      ),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Talepler"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
