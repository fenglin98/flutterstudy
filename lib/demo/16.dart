// image 组件详解
// Image.asset()  加载项目中的图片 需在pubspec.yaml中配置资源路径
// Image.network() 使用网络图片
// Image.file() 加载本地储存中的图片
//  Image.memory() 加载内存中的图片数据

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,

          // child: Image.asset( // 本地图片
          //   // width: 500,
          //   height: 100,
          //   'lib/assets/images/01.JPG',
          //   fit: BoxFit.fitHeight,
          // ),
          child: Image.network(
            "https://pic.rmb.bdstatic.com/bjh/news/91ebcebfd8dcb27ab9ed1f005b2861f0.png",
          ), // 网络图片
        ),
      ),
    );
  }
}
