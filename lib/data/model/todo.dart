class Todo {
  String content;

  Todo({
    required this.content,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    content: json['content'],
  );
}