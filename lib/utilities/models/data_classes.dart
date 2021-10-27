class Task{
  Task({
    required this.title,
    required this.isDone,
    this.from,
    this.to,
    this.description,
  });

  final String title;
  final DateTime? from;
  final DateTime? to;
  final String? description;
  bool isDone;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"],
    isDone: json["isDone"],
    from: json["from"],
    to: json["to"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "isDone": isDone,
    "from": from,
    "to": to,
    "description": description,
  };
}