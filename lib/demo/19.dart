import 'package:flutter/material.dart';

//listView 滚动组件 采用按需加载()懒加载 极大的性能优化
// 默认构造函数 适用静态数据一次性构建完成的情况
//      ListView.builder(), 按需构建列表项 通过itemCount控制列表长度 itemBuilder 构建函数
//    ListView.separated() 在  ListView.builder 的基础上增加了构建分割线的能力
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
              // child: ListView(children: getList()),
              // child: ListView.builder(
              //   itemCount: 100,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Container(
              //       height: 50,
              //       child: Text("第${index + 1}个"),
              //       alignment: Alignment.center,
              //       color: Colors.blue,
              //       margin: EdgeInsets.only(top: 10),
              //     );
              //   },
              // ),



              
              child: ListView.separated(
                itemCount: 100,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text("第${index + 1}个"),
                    alignment: Alignment.center,
                    color: Colors.blue,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.red,
                  );
                },
              ),
            ),

            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  print("去顶部");
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
