// 流式布局（Wrap、Flow）
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// wrap  流式布局  flow 不常用
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("App title")),
        // body: Row(children: <Widget>[Text("xxx" * 100)]), // row 默认只有一行 内容超出会报错
        body: Container(
          width: double.infinity, // 最大宽度
          height: double.infinity, // 最大高度
          color: Colors.yellow,
          child: Wrap(
            spacing: 10.0, // 主轴(水平)方向间距
            runSpacing: 30.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.start, //沿主轴方向居中
            children: <Widget>[
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('A'),
                ),
                label: Text('Hamilton'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('M'),
                ),
                label: Text('Lafayette'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('H'),
                ),
                label: Text('Mulligan'),
              ),
              Chip(
                avatar: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('J'),
                ),
                label: Text('Laurens'),
              ),
            ],
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
