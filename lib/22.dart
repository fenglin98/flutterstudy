import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// PageView  整页滚动容器 实现分页滚动的核心组件 例如轮播图
// controller 控制页面跳转
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  // banner 索引
  int _activeIndex = 0;
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
          slivers: [
            SliverToBoxAdapter(
              // banner
              child: Stack(
                children: [
                  Container(
                    color: Colors.blue,
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    child: PageView.builder(
                      controller: _pageController, // 控制页面跳转
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 100,
                          child: Text(
                            "页面${index + 1}",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    child: Container(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(10, (index) {
                          return GestureDetector(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: Duration(seconds: 1),
                                curve: Curves.ease,
                              );

                              // _pageController.jumpToPage(index);
                              setState(() {
                                _activeIndex = index;
                              });
                            },
                            child: Container(
                              width: 10,
                              height: 10,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: index == _activeIndex
                                    ? Colors.amber[900]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    height: 20,
                    bottom: 0,
                    left: 0,
                    right: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
