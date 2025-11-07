import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Screen/Auth/SignupScren.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/TabbarScreen.dart';
import 'package:flutter/services.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Network/ApiService.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
                                showForgotPasswordView(context);
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
                                validate();

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
      EasyLoading.showError(AlertConstants.emailBlank);
      return;
    } else if (!emailRegex.hasMatch(email)) {
      EasyLoading.showError(AlertConstants.emailInvalid);
      return;
    } else if (password.isEmpty) {
      EasyLoading.showError(AlertConstants.passwordBlank);
      return;
    } else {
      print("Login API");
      login();
    }
  }

  Future<void> login() async {
    EasyLoading.show(status: 'Login...');
    try {
      final response = await apiService.postWithoutTokenRequest(
        ApiConstants.users_login, {
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim()
        },
      );

      final data = response.data;

      if (response.statusCode == 200 || response.statusCode == 201 && data['success'] == true) {
        //  Signup success
        final userJson = data['user'];
        EasyLoading.showSuccess(data['message']);
        final accessToken = data['data']['accessToken'] ?? "";
        await saveToken(accessToken);
        Future.delayed(const Duration(seconds: 2), () {
          print("Move");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TabBarScreen(),
            ),
          );
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

  Future<void> saveToken(String token) async {
    print("token:-- $token");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }


  //Bottom Sheet for Success
  void showForgotPasswordView(BuildContext context) {
    final TextEditingController _emailResetPasswordController = TextEditingController();

    Future<void> resendEmailOTP() async {
      EasyLoading.show(status: 'Sending OTP...');
      try {
        final response = await apiService.postWithoutTokenRequest(
          ApiConstants.resend_email_otp,
          {
            "email": _emailResetPasswordController.text.trim(),
          },
        );

        final data = response.data;

        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
          EasyLoading.showSuccess(data['message']);
          Navigator.pop(context);
          otpCode = "";
          showResetPasswordView(context, _emailResetPasswordController.text.trim());
        } else {
          String errorMessage = data['errors']?['message'] ??
              data['message'] ??
              "Resend otp failed";
          EasyLoading.showError(errorMessage);
        }
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Resend otp failed: ${e.toString()}");
      }
      Navigator.pop(context);
      otpCode = "";
      showResetPasswordView(context, _emailResetPasswordController.text.trim());
    }

    Future<void> validateResetPasswordEmail() async {
      String email = _emailResetPasswordController.text.trim();

      final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      );

      if (email.isEmpty) {
        EasyLoading.showError("Please enter your email");
        return;
      } else if (!emailRegex.hasMatch(email)) {
        EasyLoading.showError("Please enter a valid email address");
        return;
      } else {
        print("Reset Password API");
        resendEmailOTP();
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   width: 50,
                    //   height: 6,
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFEDEDF6),
                    //     borderRadius: BorderRadius.circular(3),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/forgotPassword.png',
                      width: 54,
                      height: 52,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: App_BlackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Dont’ worry we will send you reset Instructions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: App_BlackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 42),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _emailResetPasswordController,
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
                    const SizedBox(height: 30),
                    Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                      print("Reset Password pressed");
                      validateResetPasswordEmail();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Reset Password",
                          style: TextStyle(
                            color: App_BlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16),
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
                    const SizedBox(height: 60),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Back to login",
                            style: TextStyle(
                              fontSize: 16,
                              color: App_light,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/close.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showResetPasswordView(BuildContext context, String emailID) {

    Future<void> emailOTPVerify() async {
      EasyLoading.show(status: 'OTP Verify...');
      try {
        final response = await apiService.postWithoutTokenRequest(
          ApiConstants.users_password_otp_verify,
          {
            "email": emailID,
            "otp": "",
          },
        );

        final data = response.data;

        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
          EasyLoading.showSuccess("OTP verify successful!");
          Navigator.pop(context);
          showNewPasswordView(context, emailID);
        } else {
          String errorMessage = data['message'] ?? "Something went wrong please try again";
          EasyLoading.showError(errorMessage);
        }
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("${e.toString()}");
      }
      Navigator.pop(context);
      showNewPasswordView(context, emailID);
    }

    Future<void> resendEmailOTP() async {
      EasyLoading.show(status: 'Sending OTP...');
      try {
        final response = await apiService.postWithoutTokenRequest(
          ApiConstants.resend_email_otp,
          {
            "email": emailID,
          },
        );

        final data = response.data;

        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
          EasyLoading.showSuccess(data['message']);
        } else {
          String errorMessage = data['errors']?['message'] ??
              data['message'] ??
              "Resend otp failed";
          EasyLoading.showError(errorMessage);
        }
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Resend otp failed: ${e.toString()}");
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 5,
            right: 5,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //   width: 50,
                    //   height: 6,
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xFFEDEDF6),
                    //     borderRadius: BorderRadius.circular(3),
                    //   ),
                    // ),
                    const SizedBox(height: 44),
                    Image.asset(
                      'assets/backEmail.png',
                      width: 54,
                      height: 52,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Reset Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: App_BlackColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "we sent a code to",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: App_sentCode,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      emailID,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: App_BlackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 35),
                    _buildOtpFields(),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                            print("Reset Password pressed");
                            print("otpCode:-===== $otpCode");
                            if (otpCode.length == 4) {
                              print("OTP 4 digit");
                              emailOTPVerify();
                            } else {
                              EasyLoading.showError("Please enter otp");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: App_BlackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 16),
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn’t receive the email?",
                            style: TextStyle(
                              color: App_code,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              print("Resend clicked");
                              resendEmailOTP();
                            },
                            child: Text(
                              "Click to resend",
                              style: TextStyle(
                                color: App_blue,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Back to login",
                            style: TextStyle(
                              fontSize: 16,
                              color: App_light,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/close.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24), // match text above
      child: PinCodeTextField(
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.circle,
          borderRadius: BorderRadius.circular(10),
          fieldHeight: 60,
          fieldWidth: 60,
          activeColor: App_ActiveOTP,
          selectedColor: App_ActiveOTP,
          inactiveColor: App_InActiveOTP,
          activeFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            otpCode = value;
          });
        },
        appContext: context,
      ),
    );
  }

  void showNewPasswordView(BuildContext context, String emailID) {
    final TextEditingController _passwordResetPasswordController = TextEditingController();
    bool isPasswordVisibleResetPasswprd = false;

    Future<void> resetPasswprd() async {
      EasyLoading.show(status: 'Loading...');
      try {
        final response = await apiService.postWithoutTokenRequest(
          ApiConstants.users_reset_password,
          {
            "email": emailID,
            "newPassword": _passwordResetPasswordController.text.trim(),
          },
        );

        final data = response.data;
        EasyLoading.dismiss();
        showAllDoneView(context);
        if ((response.statusCode == 200 || response.statusCode == 201) && data['success'] == true) {
          Navigator.pop(context);
          showAllDoneView(context);
        } else {
          String errorMessage = data['errors']?['message'] ??
              data['message'] ??
              "Reset password failed";
          EasyLoading.showError(errorMessage);
        }
      } catch (e) {
        EasyLoading.dismiss();
        EasyLoading.showError("Reset password failed: ${e.toString()}");
      }
    }

    Future<void> validatePassword() async {

      String password = _passwordResetPasswordController.text.trim();


      // Password rules
      final hasMinLength = password.length >= 8;
      final hasUppercase = password.contains(RegExp(r'[A-Z]'));
      final hasDigit = password.contains(RegExp(r'\d'));

      // Check special character using a list
      const specialChars = "!@#\$%^&*()_+-=[]{};:'\"|,.<>/?`~";
      final hasSpecialChar = password.split('').any((c) => specialChars.contains(c));

      // Password validations
      if (password.isEmpty) {
        EasyLoading.showError("Please enter your password");
        return;
      }

      // Collect missing rules
      List<String> errors = [];
      if (!hasMinLength) errors.add("• At least 8 characters");
      if (!hasUppercase) errors.add("• At least one uppercase letter");
      if (!hasDigit) errors.add("• At least one number");
      if (!hasSpecialChar) errors.add("• At least one special character");

      if (errors.isNotEmpty) {
        EasyLoading.showError("Password must include:\n${errors.join("\n")}");
        return;
      }

      print("Validation passed ✅");
      await resetPasswprd();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 44),
                        Image.asset(
                          'assets/newPassword.png',
                          width: 54,
                          height: 52,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "New Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: App_BlackColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Must be at least 8 characters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: App_BlackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: _passwordResetPasswordController,
                                  obscureText: true,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: App_BlackColor,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "New Password",
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
                                    hintText: "New Password",
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                                print("Reset Password pressed");
                                validatePassword();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      color: App_BlackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
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
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Back to login",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: App_light,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                   Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/close.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showAllDoneView(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDEDF6),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      const SizedBox(height: 44),
                      Image.asset(
                        'assets/allDone.png',
                        width: 54,
                        height: 52,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "All Done",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: App_BlackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Your password has been reset Successfully",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: App_BlackColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                              print("Reset Password pressed");
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: App_BlackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 16),
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
                      const SizedBox(height: 40),
                    ],
                  ),
                  // Cross Button (top right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        'assets/close.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


