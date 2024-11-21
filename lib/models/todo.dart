class Todo {
  final int? id;
  final String title;

  Todo({this.id, required this.title});

  // Convertir un objeto Todo a un mapa para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  // Crear un objeto Todo desde un mapa
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
    );
  }
}