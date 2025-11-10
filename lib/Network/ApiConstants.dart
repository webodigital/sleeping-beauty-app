import 'dart:io';
import 'package:dio/dio.dart';
import 'ApiConstants.dart';
import '/Network/ApiService.dart';

final apiService = ApiService();

class ApiConstants {

  static const String baseUrl = "http://64.227.123.153:5001";

  static const String users_signUp = "/users/signup";
  static const String users_login = "/users/login";
  static const String journeys = "/journeys";
  static const String resend_email_otp = "/users/forgot-password";
  static const String users_password_otp_verify = "/users/verify-otp";
  static const String users_reset_password = "/users/reset-password";
  static const String businesses_by_location = "/businesses/by-location";

  static const String noInterNet = "No internet connection. Please check your network settings and try again.";
}

var currentLat = 0.0;
var currentLong = 0.0;