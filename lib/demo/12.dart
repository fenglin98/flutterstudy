// 流式布局（Wrap、Flow）
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// wrap  流式布局  flow 不常用，数据动态生成时需要使用wrap组件控制布局始终适配
class MyApp extends StatelessWidget {
  // 创建数组
  List<Widget> getList() {
    return List.generate(10, (index) {
      return Container(width: 100, height: 100, color: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        // body: Row(children: <Widget>[Text("xxx" * 100)]), // row 默认只有一行 内容超出会报错
        body: Container(
          width: double.infinity, // 最大宽度
          height: double.infinity, // 最大高度
          color: Colors.yellow,
          child: Wrap(
            spacing: 10.0, // 主轴(水平)方向间距
            runSpacing: 30.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴开始方向排列
            runAlignment: WrapAlignment.center, //沿交叉轴方向居中
            direction: Axis.horizontal, //
            children: getList(),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
