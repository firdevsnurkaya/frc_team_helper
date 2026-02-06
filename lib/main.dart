import 'package:flutter/material.dart';

void main() {
  runApp(const FRCApp());
}

class FRCApp extends StatelessWidget {
  const FRCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FRC Team Helper',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const HomeScreen(),
    );
  }
}

class HelpRequest {
  String team;
  String pit;
  String description;
  String status;

  HelpRequest({
    required this.team,
    required this.pit,
    required this.description,
    required this.status,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HelpRequest> helpRequests = [
    HelpRequest(
      team: "Team 3646",
      pit: "42",
      description: "PWM kablo ihtiyacı",
      status: "open",
    ),
    HelpRequest(
      team: "Team 8123",
      pit: "15",
      description: "Yazılım desteği",
      status: "open",
    ),
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case "open":
        return Colors.red;
      case "assigned":
        return Colors.orange;
      case "completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "open":
        return "Açık";
      case "assigned":
        return "Atandı";
      case "completed":
        return "Tamamlandı";
      default:
        return "";
    }
  }

  void addHelpRequest(String description, String pit) {
    setState(() {
      helpRequests.add(
        HelpRequest(
          team: "Team 9999", // Şimdilik sabit
          pit: pit,
          description: description,
          status: "open",
        ),
      );
    });
  }

  void showHelpDialog() {
    final descriptionController = TextEditingController();
    final pitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Yardım Talebi Oluştur"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pitController,
                decoration: const InputDecoration(labelText: "Pit Numarası"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "İhtiyaç Açıklaması",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("İptal"),
            ),
            ElevatedButton(
              onPressed: () {
                if (descriptionController.text.isNotEmpty &&
                    pitController.text.isNotEmpty) {
                  addHelpRequest(
                    descriptionController.text,
                    pitController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text("Gönder"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FRC Team Helper"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            "Aktif Yardımlar",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: helpRequests.length,
              itemBuilder: (context, index) {
                final help = helpRequests[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          help.team,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Pit: ${help.pit}"),
                        const SizedBox(height: 8),
                        Text(help.description),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: getStatusColor(help.status),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                getStatusText(help.status),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (help.status == "open")
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    help.status = "assigned";
                                  });
                                },
                                child: const Text("Yardım Et"),
                              ),
                            if (help.status == "assigned")
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  setState(() {
                                    help.status = "completed";
                                  });
                                },
                                child: const Text("Tamamla"),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: showHelpDialog,
                child: const Text(
                  "🚨 YARDIM İSTE",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
