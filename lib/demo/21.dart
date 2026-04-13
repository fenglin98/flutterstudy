import 'package:flutter/material.dart';

// CustomScrollView  自定义滚动组件
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

// 创建吸顶类
class _sticky extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 30,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 50,
            child: Text("第${index + 1}个"),
            alignment: Alignment.center,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  @override
  // TODO: implement maxExtent 最大展开区高度
  double get maxExtent => 60;

  @override
  // TODO: implement minExtent 最小折叠区高度
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    // 滑动时是否需要重新构建
    return false;
  }
}

class _MyAppState extends State<MyApp> {
  List<Widget> getList() {
    return List.generate(100, (index) {
      return Container(
        width: 50,
        child: Text("第${index + 1}个"),
        alignment: Alignment.center,
        color: Colors.blue,
        margin: EdgeInsets.only(top: 10),
      );
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("login"), centerTitle: true),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              // banner
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                height: 100,
                alignment: Alignment.center,
                child: Text("banner", style: TextStyle(color: Colors.white)),
              ),
            ),
            SliverToBoxAdapter(child: Container(height: 10)),

            //  粘性吸顶
            SliverPersistentHeader(
              delegate: _sticky(),
              pinned: true, // 固定顶部
            ),

            SliverToBoxAdapter(child: Container(height: 10)),
            SliverList.separated(
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  child: Text("第${index + 1}个"),
                  alignment: Alignment.center,
                  color: Colors.blue,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 20);
              },
            ),
          ], // 列表
        ),
      ),
    );
  }
}
