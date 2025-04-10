class TaskModel {
  String id;
  String title;
  String description;

  TaskModel({required this.description, required this.title, required this.id});

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description};
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      description: map["description"],
      title: map["title"],
      id: id,
    );
  }
}
