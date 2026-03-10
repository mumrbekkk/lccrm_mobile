import 'package:flutter/material.dart';
import 'package:test_flutter_aapp/parent/main.dart';
import 'package:test_flutter_aapp/core/services/auth_service.dart';
import 'package:test_flutter_aapp/student/main.dart';
import 'package:test_flutter_aapp/teacher/main.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _loading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// ----------------------------------------------------------------------
  ///

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateByRole(String role) {
    Widget page;

    switch (role) {
      case "student":
        page = const StudentMainPage();
        break;
      case "parent":
        page = const ParentHomePage();
        break;
      case "teacher":
        page = const TeacherMainPage();
        break;
      default:
        _showError("Nomaʼlum rol");
        return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => page),
          (route) => false,
    );
  }



  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError("Username va parolni kiriting");
      return;
    }

    setState(() => _loading = true);

    try {
      final role = await AuthService.login(
        _usernameController.text.trim(),
        _passwordController.text,
      );
      _navigateByRole(role);
    } catch (e) {
      _showError("Server bilan bog‘lanib bo‘lmadi $e");
    } finally {
      setState(() => _loading = false);
    }
  }


  ///
  /// ----------------------------------------------------------------------
  /// Login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F3FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              /// LOGO
              Center(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A2BE2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 45,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Center(
                child: Text(
                  "LC_CRM",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Center(
                child: Text(
                  "O'quv Markaz Portali",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 40),

              /// USERNAME
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration("Username"),
              ),

              const SizedBox(height: 16),

              /// PASSWORD
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: _inputDecoration(
                  "Parol",
                  suffix: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Parolni unutdingizmi?"),
                ),
              ),

              const SizedBox(height: 24),

              /// BUTTON
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8A2BE2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Kirish",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffix,
    );
  }

}
















