import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Task {
  String description;
  bool isCompleted;

  Task(this.description, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LISTA DE TAREAS'),
        ),
        body: TaskList(),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> tasks = [];

  void addTask(String description) {
    setState(() {
      tasks.add(Task(description, false));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  tasks[index].description,
                  style: TextStyle(
                    decoration: tasks[index].isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                onTap: () {
                  toggleTask(index);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('NUEVA TAREA'),
                    content: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        addTask(value);
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('CANCELAR'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('NUEVA TAREA'),
          ),
        ),
      ],
    );
  }
}