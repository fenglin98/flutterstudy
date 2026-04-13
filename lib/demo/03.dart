// 入口函数
import 'package:flutter/material.dart';

// StatelessWidget 无状态组件 场景：创建完毕之后内部状态不可变，仅供展示。外观由外部传参决定
// StatefulWidget  有状态组件 场景：数据状态调整后 需要更新 ，内部能自我交互 。

void main() {
  runApp(MyApp());
}

// StatelessWidget  无状态组件  创建一个类
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(title: Text("App title")), // 头部栏
//         body: Container(child: Center(child: Text("这里是中部区域"))), // 中间栏
//         bottomNavigationBar: Container(
//           // 底部
//           height: 100,
//           child: Center(child: Text("这里121212121底部")),
//         ),
//         floatingActionButton: FloatingActionButton(
//           // 悬浮按钮
//           backgroundColor: Colors.red,
//           foregroundColor: Colors.black,
//           onPressed: null,
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }

// 有状态组件  创建两个类  1继承StatefulWidget 2 state<第一个类名> ，  1负责接收喝和定义参数 2 负责向内管理 并且实现内部管理

// 类 1 对外  创建内部类对象
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

// 类2 内部类 负责管理数据 管理逻辑 并且渲染视图
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(title: Text("有状态类 title")), // 头部栏
        body: Container(child: Center(child: Text("这里是中部区域"))), // 中间栏
        bottomNavigationBar: Container(
          // 底部
          height: 100,
          child: Center(child: Text("这里121212121底部")),
        ),
        floatingActionButton: FloatingActionButton(
          // 悬浮按钮
          backgroundColor: const Color.fromARGB(255, 54, 244, 95),
          foregroundColor: Colors.black,
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
