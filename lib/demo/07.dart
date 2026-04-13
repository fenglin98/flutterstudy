// Container 组件
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// this.alignment, 设置子组件在容器内部的对其方式
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

// 圆角 阴影 旋转方形案例
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center, // 子元素对其方式
          margin: EdgeInsets.all(50), // 外边距
          padding: EdgeInsets.all(10), // 内边距
          // Color 只能设置简单背景色
          decoration: BoxDecoration(
            // 更加复杂的背景样式
            color: Colors.blue, // 背景色3
            borderRadius: BorderRadius.circular(15), // 圆角
            border: Border.all(width: 2, color: Colors.yellow),
          ),
          transform: Matrix4.rotationZ(0.5), // 旋转弧度 并非角度
          // transform: Matrix4.rotationX(1), // 旋转弧度 并非角度
          child: Text('data1', style: TextStyle(color: Colors.white)),
          // color: Color.fromARGB(255, 123, 123, 123),
        ), // 中间栏
      ),
    );
  }
}
