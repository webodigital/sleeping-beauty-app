// import 'package:flutter/material.dart';
// import 'package:sleeping_beauty_app/Core/Color.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/services.dart';
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool isPasswordVisible = false;
//
//   // Add controllers
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   String otpCode = '';
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     EasyLoading.dismiss();
//
//     Future.delayed(const Duration(seconds: 5), () {
//       EasyLoading.dismiss();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Content area inside SafeArea + Scrollable
//           Expanded(
//             child: SafeArea(
//               top: true, // don't push image down, protect rest only
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.only(bottom: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 40),
//                       child: SizedBox(
//                         child: Image.asset(
//                           'assets/logo.png',
//                           fit: BoxFit.fitHeight,
//                           width: 96,
//                           height: 92,
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 34),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 32),
//                       child: Text(
//                         "Login",
//                         style: const TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 0), // space between texts
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 32),
//                       child: Text(
//                         "Please enter your details",
//                         style:  TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: App_Light_Gray_Text,
//                         ),
//                         textAlign: TextAlign.left, // optional: align text to left
//                       ),
//                     ),
//
//                     const SizedBox(height: 30),
//
//                     // Email Field
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Email",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: App_DarkGray,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           Container(
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF8F8F8),
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Color(0xFFD5D5D5)),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextField(
//                                     controller: _emailController,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: App_BlackColor,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                                       hintText: "Enter",
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 24),
//
//                     // Password Field
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 25.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Password",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: App_DarkGray,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Container(
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFF8F8F8),
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Color(0xFFD5D5D5)),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: TextField(
//                                     controller: _passwordController,
//                                     obscureText: !isPasswordVisible,
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600,
//                                       color: App_BlackColor,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       border: InputBorder.none,
//                                       contentPadding: EdgeInsets.symmetric(horizontal: 12),
//                                       hintText: "Password",
//                                       hintStyle: TextStyle(
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     isPasswordVisible
//                                         ? Icons.visibility
//                                         : Icons.visibility_off,
//                                     color: Color(0xFF60778C),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       isPasswordVisible = !isPasswordVisible;
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 0),
//
//                     // Forgot Password
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 17.0),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(6), // ripple shape
//                           onTap: () {
//                             print("Forgot Password tapped");
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 12,
//                             ),
//                             child: Text(
//                               "Forgot Password ?",
//                               style: TextStyle(
//                                   fontSize: 13,
//                                   fontWeight: FontWeight.w400,
//                                   color: Color(0xFF1783A8)
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 80),
//                     // Login Button
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                       child: SizedBox(
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: App_Warm_Gray,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                           ),
//                           onPressed: () async {
//                             await validate();
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center, // center text + image
//                             children: [
//                               Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   color: App_BlackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               const SizedBox(width: 8), // space between text and image
//                               Image.asset(
//                                 'assets/rightSideArrow.png', // replace with your image path
//                                 width: 26,
//                                 height: 26,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     const SizedBox(height: 28),
//                     // Sign Up
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             "Don't have an account?",
//                             style: TextStyle(
//                               color: App_DeepIndigo,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 13,
//                             ),
//                           ),
//                           const SizedBox(width: 6),
//                           GestureDetector(
//                             onTap: () {
//                               print("SignUP");
//                             },
//                             child: Text(
//                               "Signup",
//                               style: TextStyle(
//                                 color: Color(0xFF5669FF),
//                                 fontWeight: FontWeight.w400,
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: Color(0xFF5669FF),  // same as text color
//                                 decorationThickness: 0.75,              // thickness of the underline
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Validation function
//   Future<void> validate() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();
//
//     // Basic email validation regex
//     final emailRegex = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//
//     if (email.isEmpty) {
//       EasyLoading.showError("Please enter your email");
//       return;
//     } else if (!emailRegex.hasMatch(email)) {
//       EasyLoading.showError("Please enter a valid email address");
//       return;
//     } else if (password.isEmpty) {
//       EasyLoading.showError("Please enter your password");
//       return;
//     } else {
//       print("Login API");
//     }
//   }
// }
