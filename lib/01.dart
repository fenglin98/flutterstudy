// 入口函数
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//  定义根组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      home: Scaffold(),
    );
  }
}
