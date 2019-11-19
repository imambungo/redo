import 'package:flutter/material.dart';
import '../task.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<StatefulWidget> {
  List<Task> tasks = [
    Task(task: 'belajar mobile app', hariH: -2, periode: 4),
    Task(task: 'jogging', hariH: 3, periode: 7),
    Task(task: 'main voli', hariH: 0, periode: 2),
  ];

  Widget _taskListBuilder() {
    tasks.sort(
      (a, b) {
        if (a.hariH == b.hariH)
          return b.periode.compareTo(a.periode);
        return b.hariH.compareTo(a.hariH);
      }
    );

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1),
      itemBuilder: (context, index) {
        return _taskBuilder(tasks[index]);
      },
    );
  }

  Color _calendarColor(Task task) {
    if (task.hariH == 0)
      return Colors.blue;
    if (task.hariH > 0)
      return Colors.red;
    return Colors.grey;
  }

  String _tampilHariH(task) {
    if (task.hariH > 0)
      return ' +${task.hariH}';
    if (task.hariH < 0)
      return ' ${task.hariH}';
    return '';
  }

  Widget _taskBuilder(Task task) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
              Icons.today,
              color: _calendarColor(task),
          ),
          Text(
            //' ${task.hariH}',
            _tampilHariH(task),
          ),
        ],
      ),
      title: Text(
        task.task,
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.check,
          color: task.hariH < 0 ? Colors.green : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            task.hariH = -task.periode;
          });
        },
      ),
      onTap: () {
        _modifyTask(task);
      }
    );
  }

  dynamic _modifyTask(Task task) async {
    dynamic data = await Navigator.pushNamed(
                     context,
                     '/modify_task',
                     arguments: { 'task' : task },
                   );

    if (data['delete'])
      tasks.remove(task);

    return data;
  }

  void _addNewTask() async {
    Task newTask = Task(task: 'Task name', periode: 7, hariH: -7);
    dynamic data = await _modifyTask(newTask);

    if (data['modify'])
      tasks.add(newTask);
  }

  int _todoNumber() {
    int todo = 0;
    tasks.forEach((task) {
      if (task.hariH >= 0)
        todo++;
    });

    return todo;
  }

  Widget _todo() {
    int todo = _todoNumber();
    String result = 'TODO: $todo';

    if (todo == 0)
      result += ' 🎉';

    return Text(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 21),
          child: Column(
            children: <Widget>[
              _todo(),
              Expanded( // https://stackoverflow.com/a/49506624/9157799
                child: _taskListBuilder(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNewTask();
        },
        child: Icon(Icons.add),
        //backgroundColor: Colors.grey[400],
      ),
    );
  }
}