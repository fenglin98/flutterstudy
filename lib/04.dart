// 生命周期
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 生命周期

// 无状态组件周期 build 是无状态组件的唯一周期 ，浏览器刷新 或者 父组件传入参数发生变化 build函数会重新执行
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     print("build function");
//     return MaterialApp(
//       title: 'Flutter Demo',
//       // theme: ThemeData(scaffoldBackgroundColor: Colors.red),;
//       home: Scaffold(
//         appBar: AppBar(title: Text("App title")), // 头部栏
//         body: Container(child: Center(child: Text("无状态组件"))), // 中间栏
//         bottomNavigationBar: Container(
//           // 底部
//           height: 100,
//           child: Center(child: Text("这里底部")),
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

// 有状态组件 生命周期

// StatefulWidget 创建
//        ↓
// createState() → 创建 State 对象（对外）
//        ↓
// mounted = true
//        ↓
// initState() ← 【只调用一次】初始化 （对内）
//        ↓
// didChangeDependencies() ← 依赖变化时调用
//        ↓
// build() ← 【可能多次调用】  渲染 ui
//        ↓
// setState() 触发 → build() 重新执行
//        ↓
// didUpdateWidget() ← 父组件重建时调用 （更新阶段）
//        ↓
// deactivate() ← State 从树中移除
//        ↓
// dispose() ← 【只调用一次】永久销毁
//        ↓
// mounted = false

// 1. createState 创建阶段
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() {
    // creat（创建阶段）
    print("creat 1");
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    print("initState 1");
    super.initState();
    // initState（创建阶段）
    // ✅ 适合做：
    // _controller = TextEditingController();  // 初始化控制器
    // _future = fetchData();                  // 发起网络请求
    // addListeners();                         // 添加监听器
    // _startAnimation();                      // 启动动画
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies 2"); //  依赖 全局状态（创建阶段）
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // build 阶段
    return const Placeholder();
  }
}
