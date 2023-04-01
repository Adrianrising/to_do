import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/constant/hive_constant.dart';
import 'package:to_do_app/data/vos/to_do_vo.dart';
import 'package:to_do_app/pages/home_page.dart';

import 'constant/strings.dart';

void main() async{
  await Hive.initFlutter();

  Hive.registerAdapter(ToDoVoAdapter());

  await Hive.openBox<ToDoVo>(kToDoBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      title: kAppName,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const HomePage(),
    );
  }
}
