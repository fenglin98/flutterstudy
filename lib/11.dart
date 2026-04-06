// Flex 和 Expanded
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//  Flex 布局  row 和 column的结合体 ，
// flex 的子组件使用 Expanded 和flexible控制空间分配
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text("App title")),
//         body: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(color: Colors.yellow),
//           child: Flex(
//             // direction: Axis.horizontal, // Axis 控制flex的排列方向 水平方向
//             direction: Axis.vertical, // Axis 控制flex的排列方向 垂直方向
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Container(width: 50, color: Colors.red),
//               ),
//               Expanded(
//                 flex: 2,
//                 child: Container(width: 50, color: Colors.blue),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// 案例
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("App title")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Colors.yellow),
          child: Flex(
            // direction: Axis.horizontal, // Axis 控制flex的排列方向 水平方向
            direction: Axis.vertical, // Axis 控制flex的排列方向 垂直方向
            children: [
              Container(height: 100, color: Colors.red),
              Expanded(child: Container(color: Colors.grey)), //中间撑满 上下固定
              Container(height: 100, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
