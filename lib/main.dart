// lib/main.dart
import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/todo.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final TextEditingController _controller = TextEditingController();
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  void _refreshTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  void _addTodo() async {
    if (_controller.text.isEmpty) return;
    await _dbHelper.insertTodo(Todo(title: _controller.text));
    _controller.clear();
    _refreshTodos();
  }

  void _deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
    _refreshTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Nueva Tarea',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTodo,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTodo(todo.id!),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
