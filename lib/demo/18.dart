import 'package:flutter/material.dart';

//SingleChildScrollView 滚动组件
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> getList() {
    return List.generate(100, (index) {
      return Container(
        height: 50,
        child: Text("第${index + 1}个"),
        alignment: Alignment.center,
        color: Colors.blue,
        margin: EdgeInsets.only(top: 10),
      );
    });
  }

  ScrollController _controller =
      ScrollController(); // 滚动控制器 绑定在SingleChildScrollView上

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("login"), centerTitle: true),
        body: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                // SingleChildScrollView 包裹单个子组件 具备滚动能力
                child: Column(children: getList()),
                controller:
                    _controller, // controller 给组件的controller 绑定ScrollController对象
              ),
            ),

            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  print("去顶部");
                  // _controller.jumpTo(0);
                  _controller.animateTo(
                    0,
                    duration: Duration(seconds: 3),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: GestureDetector(
                onTap: () {
                  print("去底部");
                  // _controller.jumpTo(
                  //   _controller.position.maxScrollExtent,
                  // ); //  直接跳转 无动画 去底部
                  _controller.animateTo(
                    _controller.position.maxScrollExtent,
                    duration: Duration(seconds: 3),
                    curve: Curves.easeIn,
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
