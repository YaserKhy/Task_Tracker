class Task {
  final int id;
  String title;
  final String category;
  bool isCompleted;

  Task({required this.id, this.title="", required this.category, this.isCompleted=false});

  factory Task.fromJson(Map<String,dynamic> json) {
    return Task(id: json['id'], title: json['title'], category: json['category'], isCompleted: json['isCompleted']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title' : title,
      'category' : category,
      'isCompleted' : isCompleted
    };
  }
}