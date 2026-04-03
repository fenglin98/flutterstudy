// Scaffold
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
      // theme: ThemeData(scaffoldBackgroundColor: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: Text("App title")), // 头部栏
        body: Container(child: Center(child: Text("这里是中部区域"))), // 中间栏
        bottomNavigationBar: Container(
          // 底部
          height: 100,
          child: Center(child: Text("这里底部")),
        ),
        floatingActionButton: FloatingActionButton(
          // 悬浮按钮
          backgroundColor: Colors.red,
          foregroundColor: Colors.black,
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
