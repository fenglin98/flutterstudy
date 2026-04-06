// 线性布局 column 和 row
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//  column 列 所有子组件纵向排列  垂直排列，本身不支持滚动
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text("App title")),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.yellow, // 背景色3
//             borderRadius: BorderRadius.circular(15), // 圆角
//           ),
//           width: double.infinity,
//           height: double.infinity,
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.spaceBetween, 主轴 两端对其
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,   类似flex spaceAround
//             //  mainAxisAlignment: MainAxisAlignment.start,   star
//             //  mainAxisAlignment: MainAxisAlignment.end,
//             // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均分对齐
//             mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
//             // crossAxisAlignment: CrossAxisAlignment.start, // 交叉轴对齐 起点
//             crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴对齐 居中 默认
//             // crossAxisAlignment: CrossAxisAlignment.end, // 交叉轴对齐 终点
//             children: [
//               Container(width: 100, height: 100, color: Colors.blue),
//               Container(width: 100, height: 100, color: Colors.blue),
//               Container(width: 100, height: 100, color: Colors.blue),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// row 行 所有子组件横向排列  水平排列
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
          width: double.infinity,
          height: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, 主轴 两端对其
            // mainAxisAlignment: MainAxisAlignment.spaceAround,   类似flex spaceAround
            //  mainAxisAlignment: MainAxisAlignment.start,   star
            //  mainAxisAlignment: MainAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 均分对齐
            // mainAxisAlignment: MainAxisAlignment.center, // 居中对齐
            // crossAxisAlignment: CrossAxisAlignment.start, // 交叉轴对齐 起点
            crossAxisAlignment: CrossAxisAlignment.center, // 交叉轴对齐 居中 默认
            // crossAxisAlignment: CrossAxisAlignment.end, // 交叉轴对齐 终点
            children: [
              Container(width: 100, height: 100, color: Colors.blue),
              Container(width: 100, height: 100, color: Colors.blue),
              Container(width: 100, height: 100, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
