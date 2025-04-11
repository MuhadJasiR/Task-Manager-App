class TaskModel {
  String id;
  String title;
  String description;
  String date;
  String time;
  bool isCompleted;

  TaskModel({
    required this.description,
    required this.title,
    required this.id,
    required this.date,
    this.isCompleted = false,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      description: map["description"] ?? "",
      title: map["title"] ?? "",
      date: map["date"] ?? "",
      time: map["time"] ?? "",
      isCompleted: map['isCompleted'] ?? false,
      id: map["id"] ?? "",
    );
  }
}
