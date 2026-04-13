// 交互事件  用户点击 滑动 触摸 等
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// GestureDetector  手势检测组件
// 使用方式 GestureDetector 包裹需要做交互的元素 (使用最广)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("App title")), // 头部栏
        body: Container(
          child: Center(
            child: GestureDetector(
              child: Text("这里是中部区域"),
              onTap: () {
                // 点击事件
                print(" click 111111");
              },
              onDoubleTap: () {
                // 双击事件
                print("check 2222 ");
              },
              onLongPress: () {
                // 长按
                print(" tauch 11111");
              },
            ),
          ),
        ), // 中间栏
        bottomNavigationBar: Container(
          // 底部
          height: 100,
          child: Center(
            child: TextButton( // 部分组件自带点击事件onPressed
              onPressed: () { // onPressed()
                print("这里是底部");
              },
              child: Text("这里底部"),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // 悬浮按钮 按钮自带点击事件
          backgroundColor: Colors.red,
          foregroundColor: Colors.black,
          onPressed: () {
            print("qqqqqqqqqqqqqqqqqqq");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

// 或者使用自带事件的组件
