import 'package:flutter/material.dart';
import '../task.dart';

class ModifyTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyTaskState();
}

class _ModifyTaskState extends State<StatefulWidget> {
  Map arguments = {};
  Task task = null;

  void _updateTask() {
    Navigator.pop(context, {
      'task' : task
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    task = arguments['task'];

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Modify task'),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Task name: ${task.task}'
          ),
          Text(
            'Period: ${task.periode}'
          ),
          Text(
            'Due: ${task.hariH}'
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO
          task.task = 'neeh';
          _updateTask();
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.grey[400],
      ),
      /*
      body: Text(
        'Task name: ${task.task}\ntes'
      ),
      */
    );
  }
}
