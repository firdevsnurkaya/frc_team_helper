import 'package:flutter/material.dart';
import '../models/help_request.dart';

class HelpCard extends StatelessWidget {
  final HelpRequest request;
  final VoidCallback onComplete;

  const HelpCard({super.key, required this.request, required this.onComplete});

  Color urgencyColor(String urgency) {
    switch (urgency) {
      case "acil":
        return Colors.red;
      case "orta":
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Team ${request.teamNumber}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(request.branch),
            const SizedBox(height: 6),
            Text(request.description),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: urgencyColor(request.urgency),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                request.urgency.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            if (!request.completed)
              ElevatedButton(
                onPressed: onComplete,
                child: const Text("Yardım Et"),
              ),
            if (request.completed)
              Text(
                "Tamamlandı - Team ${request.completedBy}",
                style: const TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
