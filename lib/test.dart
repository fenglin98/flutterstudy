import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberAccount = false;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final account = _accountController.text.trim();
    final password = _passwordController.text.trim();

    if (account.isEmpty) {
      _showSnackBar('请输入账号/邮箱');
      return;
    }

    if (password.isEmpty) {
      _showSnackBar('请输入密码');
      return;
    }

    // 这里添加登录逻辑
    _showSnackBar('正在登录...');
    // TODO: 实现登录功能
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF5F7FA), Color(0xFFE8ECF1)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  // Logo/标题区域
                  _buildHeader(),
                  const SizedBox(height: 48),
                  // 登录表单
                  _buildLoginForm(),
                  const SizedBox(height: 24),
                  // 记住账号和登录按钮
                  _buildRememberAndLogin(),
                  const SizedBox(height: 40),
                  // 版权信息
                  _buildCopyright(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MF Tool(Dev)',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '专业高效的地推管理平台',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        // 账号输入框
        TextField(
          controller: _accountController,
          decoration: InputDecoration(
            labelText: '账号',
            hintText: '账号/邮箱',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // 密码输入框
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: '密码',
            hintText: '请输入密码',
            prefixIcon: const Icon(Icons.lock_outline),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberAndLogin() {
    return Column(
      children: [
        // 记住账号复选框
        Row(
          children: [
            Checkbox(
              value: _rememberAccount,
              onChanged: (bool? value) {
                setState(() {
                  _rememberAccount = value ?? false;
                });
              },
              activeColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _rememberAccount = !_rememberAccount;
                });
              },
              child: Text(
                '记住账号',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
            const Spacer(),
            // 可选：忘记密码链接
            TextButton(
              onPressed: () {
                // TODO: 忘记密码逻辑
                _showSnackBar('忘记密码功能开发中');
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                '忘记密码？',
                style: TextStyle(fontSize: 14, color: Colors.blue[600]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // 登录按钮
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('登录'),
          ),
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Column(
      children: [
        const Divider(color: Colors.grey, thickness: 0.5),
        const SizedBox(height: 16),
        Text(
          '2026 MFTool-版权所有',
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        // FlutterToast 演示区域
        _buildToastDemo(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildToastDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FlutterToast 演示',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(msg: '默认 Toast'),
              child: const Text('默认'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '顶部显示',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.black54,
              ),
              child: const Text('顶部'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '底部显示',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black54,
              ),
              child: const Text('底部'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '居中显示',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.black54,
              ),
              child: const Text('居中'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '长消息',
                toastLength: Toast.LENGTH_LONG,
              ),
              child: const Text('长消息'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '白色背景',
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ),
              child: const Text('白色'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '红色背景',
                backgroundColor: Colors.red,
                textColor: Colors.white,
              ),
              child: const Text('红色'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '绿色背景',
                backgroundColor: Colors.green,
                textColor: Colors.white,
              ),
              child: const Text('绿色'),
            ),
ElevatedButton(
              onPressed: () => Fluttertoast.showToast(
                msg: '橙色背景',
                backgroundColor: Colors.orange,
                textColor: Colors.white,
              ),
              child: const Text('橙色'),
            ),
            ElevatedButton(
              onPressed: () => Fluttertoast.cancel(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('关闭Toast'),
            ),
          ],
        ),
      ],
    );
  }
}
