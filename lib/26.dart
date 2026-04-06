import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//  路由管理 Navigator 和 route 来实现页面栈管理 
  // Navigator.push 跳转新页面
  // Navigator.pop  返回上一层

void main() {
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("食物")),
        body: Container(
        child: TextButton(onPressed: (){
          // Navigator.push(context, ())
        }, child: Text("列表页")),
        ),
      ),
    );
  }
}
