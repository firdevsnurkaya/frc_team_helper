class HelpRequest {
  final String teamNumber;
  final String branch;
  final String description;
  final String urgency;
  bool completed;
  String? completedBy;

  HelpRequest({
    required this.teamNumber,
    required this.branch,
    required this.description,
    required this.urgency,
    this.completed = false,
    this.completedBy,
  });
}
