// text 组件详解

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

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
          // child: Text(  // 基础使用
          //   "这里是文本",
          //   style: TextStyle(
          //     color: Colors.red, // 字体颜色
          //     fontSize: 30, // 大小
          //     fontStyle: FontStyle.italic, // 样式
          //     fontWeight: FontWeight.w900, // 字重
          //     decoration: TextDecoration.underline, // 是否下滑线
          //     decorationColor: Colors.amber, // 颜色
          //   ),
          // ),
          // child: Text(
          //   //
          //   "这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本这里是文本",
          //   maxLines: 1,  // 文本是否最大行数
          //   overflow: TextOverflow.ellipsis,// 超出文本如何展示
          // ),

          // 富文本效果 Text.rich 配合 TextSpan使用
          //
          child: Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight(900)),
              children: [
                TextSpan(
                  text: "段落1 ",
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(
                  text: "段落2 ",
                  style: TextStyle(color: Colors.yellow),
                ),
                TextSpan(
                  text: "段落3 ",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
