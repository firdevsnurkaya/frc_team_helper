import 'package:flutter/material.dart';
import '../models/help_request.dart';
import '../widgets/help_card.dart';

class HomeScreen extends StatelessWidget {
  final List<HelpRequest> requests;
  final Function(HelpRequest) onComplete;
  final Function(HelpRequest) onAdd;

  const HomeScreen({
    super.key,
    required this.requests,
    required this.onComplete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FRC Yardımlaşma")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return HelpCard(
            request: requests[index],
            onComplete: () => onComplete(requests[index]),
          );
        },
      ),

      // ✅ YARDIM TALEBİ BUTONU
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final teamController = TextEditingController();
              final descController = TextEditingController();
              String urgency = "orta";
              String branch = "Yazılım";

              return AlertDialog(
                title: const Text("Yeni Yardım Talebi"),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: teamController,
                        decoration: const InputDecoration(
                          labelText: "Takım Numaran",
                        ),
                      ),
                      TextField(
                        controller: descController,
                        decoration: const InputDecoration(
                          labelText: "Açıklama",
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: branch,
                        items: ["Yazılım", "Mekanik", "Elektronik", "Tasarım"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          branch = value!;
                        },
                        decoration: const InputDecoration(labelText: "Alan"),
                      ),
                      DropdownButtonFormField<String>(
                        value: urgency,
                        items: ["acil", "orta", "düşük"]
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          urgency = value!;
                        },
                        decoration: const InputDecoration(
                          labelText: "Aciliyet",
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("İptal"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final newRequest = HelpRequest(
                        teamNumber: teamController.text,
                        branch: branch,
                        description: descController.text,
                        urgency: urgency,
                      );

                      onAdd(newRequest);
                      Navigator.pop(context);
                    },
                    child: const Text("Ekle"),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
