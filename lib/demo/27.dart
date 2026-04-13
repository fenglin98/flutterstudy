import 'package:flutter/material.dart';

// 高级路由控制
void main() {
  runApp(
    MaterialApp(
      title: "标题",
      initialRoute: "/list", // 初始路由
      routes: {
        "/list": (context) => listPage(),
        // "/detail": (context) => detailPage(), //
      },
      onGenerateRoute: (settings) {
        // 不在routes中的路由 都会走到这个函数进行处理
      },
      onUnknownRoute: (settings) {
        // 不在routes中的路由以及未在onGenerateRoute进行处理 会走到这个函数进行处理  一般显示为404
      },
      home: listPage(),
    ),
  );
}

class listPage extends StatelessWidget {
  const listPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("列表页"), centerTitle: true),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // 点击跳转
              print("列表${index + 1}");
              Navigator.pushNamed(
                context,
                "/detail",
                arguments: {"detailId": index + 1}, // 路由传参
              );
            },
            child: Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text("列表${index + 1}"),
            ),
          );
        },
      ),
    );
  }
}

class detailPage extends StatefulWidget {
  const detailPage({super.key});

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  @override
  Map _routeParams = {};
  int? detailId;
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      _routeParams = ModalRoute.of(context)!.settings.arguments as Map;
      detailId = _routeParams['detailId'] as int;
      setState(() {});
      print(_routeParams);
    }); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("详情页"), centerTitle: true),
      body: Container(
        width: double.infinity,
        height: 200,
        color: Colors.amber,
        child: GestureDetector(
          child: Text("列表id:${detailId}详情页"),
          onTap: () {
            Navigator.popAndPushNamed(context, "/list");
          },
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
