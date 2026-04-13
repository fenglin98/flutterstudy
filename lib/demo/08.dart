// Align  组件 精确控制子组件在父组件的对其方式
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.red, // 背景色3
            borderRadius: BorderRadius.circular(15), // 圆角
            border: Border.all(
              width: 15,
              color: Color.fromARGB(230, 0, 122, 222),
            ),
          ),
          child: Container(
            color: Colors.amber,
            child: Align(
              // Align 组件
              alignment: Alignment.centerRight, // 对齐方式
              child: Icon(Icons.star, size: 150, color: Colors.red),
              widthFactor:1, // 宽度因子  align 组件的宽高等于 子组件以及该因子的乘积
              heightFactor: 1, // 高度因子  align 组件的宽高等于 子组件以及该因子的乘积
            ),
          ),
        ),
      ),
    );
  }
}
