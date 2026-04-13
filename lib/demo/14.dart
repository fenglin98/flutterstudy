// 层叠布局 stack/Positioned
// 层叠布局 stack/Positioned
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// stack 层叠布局组件 运行多个子组件按照z轴方向进行叠加排列
// Positioned必须作为stack的直接子组件 ，Positioned 可使用left right bottom top 将子组件定位到具体位置 类似与html 的
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,
          child: Stack(
            // alignment: Alignment.center, // 对其方式
            // children: [
            //   Container(width: 300, height: 300, color: Colors.blue),
            //   Container(width: 200, height: 200, color: Colors.red),
            //   Container(width: 100, height: 100, color: Colors.yellow),
            // ], Stack 基础使用方式
            children: [
              Positioned(
                child: Container(width: 300, height: 300, color: Colors.blue),
              ),
              Positioned(
                left: 50,
                top: 50,
                child: Container(width: 90, height: 90, color: Colors.red),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(width: 100, height: 100, color: Colors.yellow),
              ),
            ], // Positioned 类似于绝对定位 层叠顺序由列表中的排序决定
          ),
        ),
      ),
    );
  }
}
