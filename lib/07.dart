// Container 组件
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// this.alignment, 设置子组件的对其方式
// this.padding, //容器内补白，属于decoration的装饰范围
// Color color, // 背景色
// Decoration decoration, // 背景装饰  与 color 互斥
// Decoration foregroundDecoration, //前景装饰  与 color 互斥
// double width,//容器的宽度
// double height, //容器的高度
// BoxConstraints constraints, //容器大小的限制条件
// this.margin,//容器外补白，不属于decoration的装饰范围
// this.transform, //变换
// this.child,

//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        body: Container(
          width: 200,
          height: 100,
          margin: EdgeInsets.all(50), // 外边距
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red, // 背景色3
            borderRadius: BorderRadius.circular(15), // 圆角
            border: Border.all(
              width: 15,
              color: Color.fromARGB(230, 0, 122, 222),
            ),
          ),
          transform: Matrix4.rotationZ(0.1),
          child: Center(
            // Center的使用
            child: Text('data1', style: TextStyle(color: Colors.amber)),
          ),
          // color: Color.fromARGB(255, 123, 123, 123),
        ), // 中间栏
      ),
    );
  }
}
