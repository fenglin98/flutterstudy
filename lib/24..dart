import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// 组件通信 子传父(回调函数)
//1. 父组件传递一个函数给子组件 2.子组件调用该函数  3. 父组件通过回调函数获取参数
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _foodList = ['番茄炒蛋', '鱼香肉丝', '锅包肉', '豆干炒肉', '烤生蚝', '烧鸭', '红烧肉', '溜肉段'];
  String? _foodName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("食物${_foodName}")),
        body: Container(
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            crossAxisCount: 2,
            children: List.generate(_foodList.length, (int index) {
              return childPage(
                foodName: _foodList[index],
                getfoodName: (String name) {
                  _foodName = name;
                  setState(() {});
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

// 案例
class childPage extends StatefulWidget {
  final String? foodName; //
  final Function(String) getfoodName;
  const childPage({super.key, this.foodName, required this.getfoodName});
  @override
  State<childPage> createState() => _childPageState();
}

class _childPageState extends State<childPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "${widget.foodName}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Positioned(
          child: IconButton(
            onPressed: () {
              print("${widget.foodName}");
              widget.getfoodName("${widget.foodName}");
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
          right: 20,
          top: 10,
        ),
      ],
    );
  }
}
