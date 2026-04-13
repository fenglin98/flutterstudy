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
      // 基础组件
      title: 'Flutter Demo', // 展示窗口内容 可不写
      theme: ThemeData(scaffoldBackgroundColor: Colors.red), // 设置应用整体主题
      home: Scaffold(), //展示窗口主体内容
    );
  }
}
