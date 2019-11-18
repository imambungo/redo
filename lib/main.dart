import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/modify_task.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => Home(),
    '/modifytask': (context) => ModifyTask(),
  }
));
