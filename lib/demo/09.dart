// padding  组件 精确控制子组件在父组件的对其方式
// EdgeInsetsGeometry 属性
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
          // padding: EdgeInsets.all(20), // 属性的方式 增加padding
          decoration: BoxDecoration(
            color: Colors.yellow, // 背景色3
            borderRadius: BorderRadius.circular(15), // 圆角
          ),
          child: Padding(
            // padding: EdgeInsetsGeometry.all( 50,),  全方向padding
            // padding: EdgeInsetsGeometry.only(left: 50, right: 20), // 四方向可选
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 50,
            ), //对称方向的padding  horizontal 横向 vertical 纵向
            child: Container(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
