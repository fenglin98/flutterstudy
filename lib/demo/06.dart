// 状态管理
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 状态更新 setState,  setState方法会造成build的重新执行

// 创建有状态组件
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

// 类2 内部类 负责管理数据 管理逻辑 并且渲染视图
class _MyAppState extends State<MyApp> {
  int num = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("有状态类 title")), // 头部栏
        body: Center(
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    ++num;
                    print(num);
                  });
                },
                child: Text("+"),
              ),
              Text('${num}'),
              TextButton(
                onPressed: () {
                  setState(() {
                    --num;
                    print(num);
                  });
                },
                child: Text("-"),
              ),
            ],
          ),
        ), // 中间栏
        bottomNavigationBar: Container(
          // 底部
          height: 100,
          child: Center(child: Text("这里底部")),
        ),
        floatingActionButton: FloatingActionButton(
          // 悬浮按钮
          backgroundColor: const Color.fromARGB(255, 54, 244, 95),
          foregroundColor: Colors.black,
          onPressed: () {
            setState(() {});
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
