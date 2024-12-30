import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  TextEditingController _controller = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', tasks);
  }

  void _addTask() {
    String newTask = _controller.text;
    if (newTask.isNotEmpty) {
      setState(() {
        tasks.add(newTask);
        _controller.clear();
        _saveTasks();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        backgroundColor: Colors.orangeAccent, // Change the color here
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
                    decoration: InputDecoration(labelText: 'New Task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_task),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(tasks[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever_outlined),
                  onPressed: () => _removeTask(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}