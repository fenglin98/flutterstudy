import 'package:flutter/material.dart';

// 组件通信 父传子(构造函数传递参数)
//1. 子组件定义接受属性 2. 子组件在构造函数中 接受参数 ，3. 父组件传递属性给子组件 4. 有状态组件在 对外的类 接收属性 ，对内的类 通过widget对象获取对应属性 5. 子组件定义接收属性 需要使用 final 关键字 因为子组件只是接收属性 不能进行更改
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List _foodList = ['番茄炒蛋', '鱼香肉丝', '锅包肉', '豆干炒肉', '烤生蚝', '烧鸭', '红烧肉', '溜肉段'];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            children: List.generate(_foodList.length, (int index) {
              return childPage(foodName: _foodList[index]);
            }),
          ),
        ),
      ),
    );
  }
}

// 无状态情况
// class childPage extends StatelessWidget {
//   final String? message; // 定义接收属性
//   const childPage({super.key, this.message}); // 在构造函数中接受属性·
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("子组件 ${message}", style: TextStyle(color: Colors.red)),
//     );
//   }
// }

// 有状态组件使用
// class childPage extends StatefulWidget {
//   final String? message; // 定义接收属性
//   const childPage({super.key, this.message});

//   @override
//   State<childPage> createState() => _childPageState();
// }

// class _childPageState extends State<childPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text("子组件 ${widget.message}", style: TextStyle(color: Colors.red)),
//     );
//   }
// }

// 案例
class childPage extends StatefulWidget {
  final String? foodName;
  const childPage({super.key, this.foodName});
  @override
  State<childPage> createState() => _childPageState();
}

class _childPageState extends State<childPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        "${widget.foodName}",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
