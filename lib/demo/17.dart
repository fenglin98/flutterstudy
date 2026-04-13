// TextField(),组件详解 输入框
//controller:  获取，设置 文档内容
//decoration: 当时输入框的外观 如标签 提示文字 图标 边框
//style: 输入文本的样式
//maxLines 最大的行数
//onChanged  输入事件
//onSubmitted 提交的回调函数
        // obscureText: true, // 不展示输入内容 用来做密码框
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _account = TextEditingController();
  TextEditingController _psw = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("login"), centerTitle: true),
        body: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.yellow,
                  filled: true,
                  hintText: "请输入账号",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                controller: _account,
                // style: ,
                // maxLines: ,
                // onChanged: ,
                // onSubmitted: ,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _psw,
                decoration: InputDecoration(
                  fillColor: Colors.yellow,
                  filled: true,
                  hintText: "请输入密码",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                obscureText: true, // 不展示输入内容 用来做密码框
                // style: ,
                // maxLines: ,
                // onChanged: , // 输入事件
                // onSubmitted: , // 提交事件
              ),
              TextButton(
                onPressed: () {
                  print("login ${_account.text} + ${_psw.text}");
                },
                child: Text("登录"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

