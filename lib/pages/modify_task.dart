import 'package:flutter/material.dart';
import '../task.dart';
import 'package:numberpicker/numberpicker.dart';

class ModifyTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModifyTaskState();
}

class _ModifyTaskState extends State<StatefulWidget> {
  Map arguments = {};
  Task task;

  TextEditingController taskController = TextEditingController(text: '');
  int period;

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    task = arguments['task'];

    if (taskController.text == '')
      taskController.text = task.task;

    period = task.periode;

    return Scaffold(
      //backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Modify task'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, {'delete': true});
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: taskController,
              onSaved: (newTask) {
                taskController.text = newTask;
              },
              decoration: InputDecoration(
                            hintText: 'Task name',
                          ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Repeat every'),
                NumberPicker.integer(
                    initialValue: task.periode,
                    minValue: 1,
                    maxValue: 30,
                    onChanged: (newValue) {
                      period = newValue;
                    },
                ),
                Text('day(s)'),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          task.task = taskController.text;
          task.periode = period;
          if (task.hariH < -task.periode)
            task.hariH = -task.periode;

          Navigator.pop(context, {'delete': false, 'modify': true});
        },
        //backgroundColor: Colors.grey[400],
      ),
    );
  }
}
