import 'package:flutter/material.dart';

// GridView 创建二维可滚动布局
// 默认构造函数 适用静态数据一次性构建完成的情况
// GridView.count   固定列数的网格布局
// GridView.extent 固定子项的最大宽度/高度的网格布局
// GridView.builder  数量巨大 或需要动态生成的情况 需要接受  gridDelegate 布局委托属性
//
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

              // child: GridView.count(
              //   //GridView.count   固定列数的网格布局
              //   crossAxisSpacing: 10, // 轴间距
              //   mainAxisSpacing: 10, //  轴间距
              //   crossAxisCount: 3, // 主轴最大个数
              //   // scrollDirection: Axis.horizontal, // 修改滚动方向
              //   scrollDirection: Axis.vertical, // 修改滚动方向
              //   children: List.generate(100, (index) {
              //     return Container(
              //       width: 50,
              //       height: 50,
              //       child: Text("第${index + 1}个"),
              //       alignment: Alignment.center,
              //       color: Colors.blue,
              //     );
              //   }),
              // ),

              // GridView.extent 固定子项的最大宽度/高度的网格布局
              // child: GridView.extent(
              //   maxCrossAxisExtent:  100, //
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              //   children: List.generate(100, (index) {
              //     return Container(
              //       width: 50,
              //       height: 50,
              //       child: Text("第${index + 1}个"),
              //       alignment: Alignment.center,
              //       color: Colors.blue,
              //     );
              //   }),
              // ),
              child: GridView.builder(
                // 懒加载
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //按照列数去固定
                  crossAxisCount: 4, //
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2, // 子元素宽高比
                ),
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Text("第${index + 1}个"),
                    alignment: Alignment.center,
                    color: Colors.blue,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
