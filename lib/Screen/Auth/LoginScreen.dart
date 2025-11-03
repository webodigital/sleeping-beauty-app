import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Screen/Auth/SignupScren.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/TabbarScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String otpCode = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
    Future.delayed(const Duration(seconds: 5), () {
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/bottomView.png',
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.fitHeight,
                            width: 96,
                            height: 92,
                          ),
                        ),
                        const SizedBox(height: 34),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Login",
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            "Please enter your details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: App_Light_Gray_Text,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        const SizedBox(height: 40),

                        //Email Field (Floating Label)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _emailController,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: App_BlackColor,
                            ),
                            decoration: InputDecoration(
                              labelText: "Email ID",
                              labelStyle: TextStyle(
                                color: App_DarkGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              floatingLabelStyle: TextStyle(
                                color: App_DarkGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              hintText: "rachel@gmail.com",
                              hintStyle: const TextStyle(
                                color: App_DarkGray,
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF8F8F8),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                const BorderSide(color: Color(0xFFD5D5D5)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                const BorderSide(color: Color(0xFFD5D5D5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Color(0xFF60778C), width: 1.4),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Password Field (Floating Label + Eye Toggle)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: App_BlackColor,
                              letterSpacing: 1.2,
                            ),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: App_DarkGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              floatingLabelStyle: const TextStyle(
                                color: App_DarkGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF8F8F8),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                const BorderSide(color: Color(0xFFD5D5D5)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                const BorderSide(color: Color(0xFFD5D5D5)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                    color: Color(0xFF60778C), width: 1.4),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: const Color(0xFF60778C),
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        // Forgot Password
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 17.0, vertical: 4),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(6),
                              onTap: () {
                                print("Forgot Password tapped");
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 12),
                                child: const Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF1783A8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 80),

                        // Login Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: App_Warm_Gray,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () async {
                                print("Login pressed");

                                // Navigate to TabBarScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const TabBarScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                      color: App_BlackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Image.asset(
                                    'assets/rightSideArrow.png',
                                    width: 26,
                                    height: 26,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Sign Up Section
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: App_DeepIndigo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SignupScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Signup",
                                  style: TextStyle(
                                    color: Color(0xFF5669FF),
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFF5669FF),
                                    decorationThickness: 0.75,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]),
    );
  }

  Future<void> validate() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (email.isEmpty) {
      EasyLoading.showError("Please enter your email");
      return;
    } else if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError("Please enter a valid email address");
      return;
    } else if (password.isEmpty) {
      EasyLoading.showError("Please enter your password");
      return;
    } else {
      print("Login API");
    }
  }
}

