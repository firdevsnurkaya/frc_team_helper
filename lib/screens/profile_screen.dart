import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final Function(String) onSave;

  const ProfileScreen({super.key, required this.onSave});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Takım Numaran"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onSave(controller.text);
              },
              child: const Text("Kaydet"),
            ),
          ],
        ),
      ),
    );
  }
}
