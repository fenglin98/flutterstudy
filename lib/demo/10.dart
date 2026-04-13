// 线性布局 column 和 row
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//  column 列 所有子组件纵向排列  垂直排列
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("App title")),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.yellow, // 背景色3
            borderRadius: BorderRadius.circular(15), // 圆角
          ),
          child: Column(
            //测试Row对齐方式，排除Column默认居中对齐的干扰
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 直接使用
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // 子组件主轴居中
                children: [
                  Text(" hello world "),
                  Text(" 这里是中文 "),
                  Text(" 这里是数字11111 "),
                ],
              ),
              Row(
                // mainAxisAlignment：表示子组件在Row所占用的水平空间内对齐方式，如果mainAxisSize值为MainAxisSize.min，则此属性无意义，因为子组件的宽度等于Row的宽度。只有当mainAxisSize的值为MainAxisSize.max时，此属性才有意义，
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(" hello world "), Text(" I am Jack ")],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .end, // MainAxisAlignment.start表示沿textDirection的初始方向对齐，如textDirection取值为TextDirection.ltr时，则MainAxisAlignment.start表示左对齐，textDirection取值为TextDirection.rtl时表示从右对齐。而MainAxisAlignment.end和MainAxisAlignment.start正好相反；
                textDirection: TextDirection.ltr,
                children: [Text(" hello world "), Text(" I am Jack ")],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                children: [
                  Text(" hello world ", style: TextStyle(fontSize: 30.0)),
                  Text(" I am Jack "),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
