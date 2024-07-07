class Todo {
  String id;
  String content;

  Todo({
    required this.id,
    required this.content,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'],
    content: json['content'],
  );
}