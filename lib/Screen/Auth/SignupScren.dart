import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Network/ApiService.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordVisible = false;

  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String otpCode = '';

  @override
  void dispose() {
    _passwordController.dispose();
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

    _NameController.addListener(() {
      final text = _NameController.text;

      if (text.startsWith(" ")) {
        _NameController.text = text.trimLeft(); // remove leading spaces
        _NameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _NameController.text.length),
        );
      }
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
              fit: BoxFit.fill,
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
                          padding:  EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            lngTranslation("Signup"),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            lngTranslation("Please enter your details"),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: App_Light_Gray_Text,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _NameController,
                            inputFormatters: [
                              SingleSpaceInputFormatter(),
                            ],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: App_BlackColor,
                            ),
                            decoration: InputDecoration(
                              labelText: lngTranslation("Full Name"),
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
                              filled: true,
                              fillColor: const Color(0xFFF8F8F8),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
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

                        const SizedBox(height: 26),

                        //Email Field (Floating Label)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _emailController,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            ],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: App_BlackColor,
                            ),
                            decoration: InputDecoration(
                              labelText: lngTranslation("Email ID"),
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
                              filled: true,
                              fillColor: const Color(0xFFF8F8F8),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 14),
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

                        const SizedBox(height: 26),

                        // Password Field (Floating Label + Eye Toggle)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !isPasswordVisible,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r"\s")),
                            ],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: App_BlackColor,
                              letterSpacing: 1.2,
                            ),
                            decoration: InputDecoration(
                              labelText: lngTranslation("Password"),
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
                                  horizontal: 14, vertical: 14),
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

                        const SizedBox(height: 45),

                        // Sign Button
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
                                await validate();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    lngTranslation("Signup"),
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
                               Text(
                                lngTranslation("Already have an account?"),
                                style: TextStyle(
                                  color: App_DeepIndigo,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                child: Text(
                                  lngTranslation("Login"),
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
        ])
    );
  }

  Future<void> validate() async {
    String name = _NameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );

    // Password: 6+ chars, allow special chars, must include upper, lower, number
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}$'
    );

    if (name.isEmpty) {
      EasyLoading.showError(lngTranslation(AlertConstants.userNameBlank));
      return;
    } else if (email.isEmpty) {
      EasyLoading.showError(lngTranslation(AlertConstants.emailBlank));
      return;
    } else if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError(lngTranslation(AlertConstants.emailInvalid));
      return;
    } else if (password.isEmpty) {
      EasyLoading.showError(lngTranslation(AlertConstants.passwordBlank));
      return;
    } else if (!passwordRegex.hasMatch(password)) {
      EasyLoading.showError(
          lngTranslation("Password must be at least 6 characters long and include 1 uppercase letter, 1 lowercase letter, and 1 number.")
      );
      return;
    } else {
      print("SignUP API");
     signUP();
    }
  }

  Future<void> signUP() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
        return;
    }

    EasyLoading.show(status: lngTranslation('Signup...'));
    try {
      final response = await apiService.postWithoutTokenRequest(
        ApiConstants.users_signUp,
        {
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
          "fullName": _NameController.text.trim(),
          "role": "USER"
        },
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201 && data['success'] == true) {
        //  Signup success
        final userJson = data['user'];
        EasyLoading.showSuccess(AlertConstants.signUpDoneLogin);
        Future.delayed(const Duration(seconds: 3), () {
           print("Move");
           Navigator.pop(context);
        });
      } else  {
        String errorMessage = data['message'];
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    }
  }
}

class SingleSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;

    // Remove leading spaces
    text = text.replaceFirst(RegExp(r'^ +'), '');

    // Replace multiple spaces with a single space
    text = text.replaceAll(RegExp(r' {2,}'), ' ');

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

