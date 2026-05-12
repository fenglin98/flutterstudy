import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oktoast/oktoast.dart';
import 'package:t_overlay_notification/t_overlay_notification.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberAccount = false;
  String _selectedRole = 'user';
  final List<Map<String, String>> _roles = [
    {'value': 'admin', 'label': '管理员'},
    {'value': 'user', 'label': '普通用户'},
    {'value': 'guest', 'label': '访客'},
  ];

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
        // DropdownMenu 角色选择
        DropdownMenu<String>(
          initialSelection: _selectedRole,
          label: const Text('角色'),
          leadingIcon: const Icon(Icons.badge_outlined),
          dropdownMenuEntries: _roles.map((r) {
            return DropdownMenuEntry<String>(
              value: r['value']!,
              label: r['label']!,
            );
          }).toList(),
          onSelected: (String? value) {
            setState(() {
              _selectedRole = value ?? 'user';
            });
            final label = _roles.firstWhere((r) => r['value'] == _selectedRole)['label'];
            showToast('选择角色: $label', duration: const Duration(seconds: 1));
          },
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
        const SizedBox(height: 32),
        // OKToast 演示区域
        _buildOKToastDemo(),
        const SizedBox(height: 20),
        // TOverlayNotification 演示区域
        _buildTOverlayDemo(),
      ],
    );
  }

  Widget _buildOKToastDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'OKToast 演示',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text('基础用法', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => showToast('默认 OKToast'),
              child: const Text('默认'),
            ),
            ElevatedButton(
              onPressed: () => showToast('底部显示', position: ToastPosition.bottom),
              child: const Text('底部'),
            ),
            ElevatedButton(
              onPressed: () => showToast('顶部显示', position: ToastPosition.top),
              child: const Text('顶部'),
            ),
            ElevatedButton(
              onPressed: () => showToast('居中显示', position: ToastPosition.center),
              child: const Text('居中'),
            ),
            ElevatedButton(
              onPressed: () => showToast('3秒后消失', duration: const Duration(seconds: 3)),
              child: const Text('3秒'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('自定义样式 (使用 showToastWidget)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildOKToastColorBtn('红色', Colors.red),
            _buildOKToastColorBtn('绿色', Colors.green),
            _buildOKToastColorBtn('蓝色', Colors.blue),
            _buildOKToastColorBtn('橙色', Colors.orange),
            _buildOKToastColorBtn('紫色', Colors.purple),
          ],
        ),
        const SizedBox(height: 16),
        const Text('带图标', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildOKToastIconBtn('操作成功', Icons.check_circle, Colors.green),
            _buildOKToastIconBtn('出错了', Icons.error, Colors.red),
            _buildOKToastIconBtn('警告信息', Icons.warning, Colors.orange),
            _buildOKToastIconBtn('提示信息', Icons.info, Colors.blue),
          ],
        ),
        const SizedBox(height: 16),
        const Text('圆角 Toast', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => showToastWidget(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('大圆角Toast', style: TextStyle(color: Colors.white)),
                ),
                duration: const Duration(seconds: 2),
              ),
              child: const Text('大圆角'),
            ),
            ElevatedButton(
              onPressed: () => showToastWidget(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('小圆角Toast', style: TextStyle(color: Colors.white)),
                ),
                duration: const Duration(seconds: 2),
              ),
              child: const Text('小圆角'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('长文本', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => showToast(
                '这是一条比较长的消息，用于测试长文本的显示效果和布局适应性。',
                duration: const Duration(seconds: 3),
              ),
              child: const Text('长文本测试'),
            ),
            ElevatedButton(
              onPressed: () => showToastWidget(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    '多行文本测试\n第二行内容\n第三行内容',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
                duration: const Duration(seconds: 3),
              ),
              child: const Text('多行文本'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('控制', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => dismissAllToast(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('dismissAllToast'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOKToastColorBtn(String text, Color color) {
    return ElevatedButton(
      onPressed: () => showToastWidget(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
        duration: const Duration(seconds: 2),
      ),
      child: Text(text),
    );
  }

  Widget _buildOKToastIconBtn(String text, IconData icon, Color color) {
    return ElevatedButton(
      onPressed: () => showToastWidget(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(text, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
      child: Text(text),
    );
  }

  Widget _buildTOverlayDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TOverlayNotification 演示',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text('通知类型', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => TNotificationOverlay.success(
                context: context,
                title: '成功',
                subTitle: '操作已成功完成',
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('成功'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.error(
                context: context,
                title: '错误',
                subTitle: '发生了错误，请重试',
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('错误'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.warning(
                context: context,
                title: '警告',
                subTitle: '请注意，这是一条警告信息',
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('警告'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.info(
                context: context,
                title: '信息',
                subTitle: '这是一条提示信息',
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('信息'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('通用显示', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '自定义标题',
                subTitle: '这是自定义消息内容',
                type: NotificationType.success,
              ),
              child: const Text('自定义成功'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '紫色主题',
                subTitle: '使用紫色通知类型',
                type: NotificationType.info,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('紫色主题'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '自定义颜色',
                subTitle: '蓝色背景白色文字',
                type: NotificationType.info,
                backgroundColor: Colors.blue,
                titleColor: Colors.white,
                messageColor: Colors.white,
              ),
              child: const Text('自定义样式'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '置顶通知',
                subTitle: '3秒后自动关闭',
                type: NotificationType.info,
                position: NotificationPosition.topRight,
              ),
              child: const Text('顶部右侧'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '底部通知',
                subTitle: '显示在底部居中',
                type: NotificationType.success,
                position: NotificationPosition.bottomCenter,
              ),
              child: const Text('底部居中'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.show(
                context: context,
                title: '持久通知',
                subTitle: '点击关闭按钮移除',
                type: NotificationType.warning,
                sticky: true,
              ),
              child: const Text('持久(Sticky)'),
            ),
            ElevatedButton(
              onPressed: () => TNotificationOverlay.closeAll(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('关闭全部'),
            ),
          ],
        ),
      ],
    );
  }
}
