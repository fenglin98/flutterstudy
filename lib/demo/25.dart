import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

//  dio 网络请求
void main() {
  // 基础使用
  // Dio()
  //     .get("https://geek.itheima.net/v1_0/channels")
  //     .then((res) => {print("${res}")});
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  void _getData() async {
    DioUtils until = DioUtils();
    // await  until.get('/channels');
    until.get('/channels').then((res) {
      print("${res.data}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("食物")),
        body: Container(),
      ),
    );
  }
}

// 封装dio
class DioUtils {
  final Dio _dio = Dio();
  DioUtils() {
    _dio.options.baseUrl = "https://geek.itheima.net/v1_0/"; // 基地址
    _dio.options.connectTimeout = Duration(seconds: 10); // 链接超时时间
    _dio.options.sendTimeout = Duration(seconds: 10); // 发送超时时间
    _dio.options.receiveTimeout = Duration(seconds: 10); // 接收超时时间

    // 拦截器
    // _dio.interceptors
    _addInterceptors();
  }
  // 拦截器函数
  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (options, handler) {
          // handler.next(); 放过请求
          // handler.reject() 拦截请求;
          handler.next(options);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // handler.next(); 放过请求
          // handler.reject() 拦截请求;
          switch (response.statusCode) {
            case 200:
              // 正常响应
              handler.next(response);
              break;
            case 201:
              // 创建成功
              handler.next(response);
              break;
            case 400:
              // 请求错误
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: '请求错误 (400)',
                ),
              );
              break;
            case 401:
              // 未授权
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: '未授权，请重新登录 (401)',
                ),
              );
              break;
            case 403:
              // 禁止访问
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: '禁止访问 (403)',
                ),
              );
              break;
            case 404:
              // 未找到
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: '资源未找到 (404)',
                ),
              );
              break;
            case 500:
              // 服务器错误
              handler.reject(
                DioException(
                  requestOptions: response.requestOptions,
                  response: response,
                  message: '服务器内部错误 (500)',
                ),
              );
              break;
            default:
              handler.next(response);
          }
        },
        // 错误拦截器
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  //  暴露请求
  get(String url, {Map<String, dynamic>? params}) {
    return _dio.get(url, queryParameters: params);
  }
}
