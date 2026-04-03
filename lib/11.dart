// Flex 和 Expanded
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//  Flex 布局 Expanded 只能作为 Flex 的孩子（否则会报错)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("App title")),
        body: Column(
          children: <Widget>[
            //Flex的两个子widget按1：2来占据水平空间
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(height: 30.0, color: Colors.red),
                ),
                Expanded(
                  flex: 2,
                  child: Container(height: 30.0, color: Colors.green),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 100.0,
                //Flex的三个子widget，在垂直方向按2：1：1来占用100像素的空间
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(height: 30.0, color: Colors.red),
                    ),
                    Spacer(flex: 1),
                    Expanded(
                      flex: 1,
                      child: Container(height: 30.0, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
