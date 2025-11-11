import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:sleeping_beauty_app/Network/Gloabal.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';


// Dummy current location values
String currentLat = "0.0";
String currentLong = "0.0";

class ApiService {
  final Dio _dio;


  ApiService()
      : _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
    ),
  ) {
    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    // Add error interceptor to handle 401 globally
    _dio.interceptors.add(InterceptorsWrapper(
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioError e, handler) async {
        if (e.response?.statusCode == 401) {
          EasyLoading.dismiss();
          await clearToken();
          // Redirect to login screen
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            '/login',
                (route) => false,
          );
          EasyLoading.dismiss();
        }
        handler.next(e);
      },
    ));
  }

  // PUT request with optional params and data
  Future<Response> putRequestWithParam(
      String endpoint, {
        Map<String, dynamic>? queryParams,
        dynamic data,
      }) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    try {
      final token = await getToken();
      final headers = {
        HttpHeaders.authorizationHeader: token ?? "",
        HttpHeaders.contentTypeHeader: "application/json",
      };
      final response = await _dio.put(
        endpoint,
        data: data ?? {},
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response;
    } on DioError catch (e) {
      throw Exception("PUT request failed: ${e.message}");
      EasyLoading.dismiss();
    } catch (e) {
      throw Exception("Unexpected error: $e");
      EasyLoading.dismiss();
    }
  }

  // GET request with optional query params
  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }
    final token = await getToken();
    if (token == null) throw Exception("Authorization token not found.");

    final headers = {
      HttpHeaders.authorizationHeader: token,
    };

    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );

      final data = response.data;

      // Handle API-level unauthorized
      if (data is Map<String, dynamic> &&
          (data['status_code'] == 401 || data['success'] == false && data['message']?.toLowerCase().contains("unauthorized") == true)) {
        EasyLoading.dismiss();
        await clearToken();
        // Redirect to login screen
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
              (route) => false,
        );
        EasyLoading.showInfo("Session expired. Please log in again.");
        throw Exception("Session expired. Please log in again.");
      }
      return response;
    } on DioError catch (e) {
      throw Exception("GET request failed: ${e.message}");
      EasyLoading.dismiss();
    } catch (e) {
      throw Exception("Unexpected error: $e");
      EasyLoading.dismiss();
    }
  }

  // GET with params
  Future<Response> getRequestWithParam(
      String endpoint, {
        Map<String, dynamic>? queryParams,
      }) async {

    print("queryParams:-- $queryParams");
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }
    try {
      final token = await getToken();
      final headers = {
        HttpHeaders.authorizationHeader: token ?? "",
      };
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response;
    } on DioError catch (e) {
      throw Exception("GET request failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // POST request without token
  Future<Response> postWithoutTokenRequest(String endpoint, Map<String, dynamic> data) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    try {
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "lat": currentLat,
        "long": currentLong,
      };
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on SocketException {
      throw Exception("No internet connection");
    } on DioError catch (e) {
      throw Exception("POST request failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // Upload photo example
  Future<Response> uploadPhoto({
    required String endpoint,
    required bool isIreland,
    required String ppsNumber,
    required bool isDrive,
    required int visaTypeId,
    required String driverLicenseUrl,
  }) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }
    try {
      dynamic driverLicenseField = "";

      if (isDrive && driverLicenseUrl.isNotEmpty) {
        if (driverLicenseUrl.startsWith("http")) {
          final response = await http.get(Uri.parse(driverLicenseUrl));
          if (response.statusCode == 200) {
            final bytes = response.bodyBytes;
            driverLicenseField = MultipartFile.fromBytes(
              bytes,
              filename: driverLicenseUrl.split('/').last,
            );
          } else {
            throw Exception("Failed to download remote file");
          }
        } else {
          driverLicenseField = await MultipartFile.fromFile(
            driverLicenseUrl,
            filename: driverLicenseUrl.split('/').last,
          );
        }
      }

      final formData = FormData.fromMap({
        "isIreland": isIreland,
        "ppsNumber": ppsNumber,
        "isDrive": isDrive,
        "visaTypeId": visaTypeId,
        "driverLicenseUrl": driverLicenseField,
      });

      final token = await getToken();
      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        if (token != null) HttpHeaders.authorizationHeader: token,
      };

      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } on SocketException {
      throw Exception("No internet connection");
    } on DioError catch (e) {
      throw Exception("Upload failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected upload error: $e");
    }
  }

  // User clock-out with signature
  Future<Response> userClockOut({
    required String endpoint,
    required int jobId,
    required String staffId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int breakMinutes,
    required String managerName,
    required String managerEmail,
    required Uint8List signatureBytes,
  }) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    final token = await getToken();
    if (token == null) throw Exception("Authorization token not found.");

    final signatureFile = MultipartFile.fromBytes(
      signatureBytes,
      filename: "signature.png",
      contentType: MediaType("image", "png"),
    );

    final formData = FormData.fromMap({
      "jobId": jobId,
      "staffId": staffId,
      "checkIn": checkIn.toUtc().toIso8601String(),
      "checkOut": checkOut.toUtc().toIso8601String(),
      "break": breakMinutes,
      "managerName": managerName,
      "managerEmail": managerEmail,
      "managerSignUrl": signatureFile,
    });

    final response = await _dio.post(
      endpoint,
      data: formData,
      options: Options(
        headers: {
          HttpHeaders.authorizationHeader: token,
          HttpHeaders.acceptHeader: "application/json",
        },
        contentType: "multipart/form-data",
      ),
    );

    return response;
  }

  // Token helpers
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null || token.isEmpty) {
      return null;
    }
    return "Bearer $token";
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }

  // POST with tokena
  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    final token = await getToken();
    if (token == null) throw Exception("Authorization token not found.");

    try {
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: token,
      };
      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );
      return response;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(
          "POST failed: ${e.response?.statusCode} ${e.response?.data}",
        );
      }
      throw Exception("POST request failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // PATCH request with token
  Future<Response> patchRequestWithParam(
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    try {
      final token = await getToken();
      if (token == null) throw Exception("Authorization token not found.");

      final headers = {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: "application/json",
      };

      final response = await _dio.patch(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );

      return response;
    } on DioError catch (e) {
      throw Exception("PATCH request failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  // Upload document photo
  Future<Response> uploadDocumentPhoto({
    required String endpoint,
    required int docId,
    required String docUrl,
    required String docExpire,
  }) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    try {
      final formData = FormData.fromMap({
        "docId": docId,
        "docExpire": docExpire,
        "docUrl": await MultipartFile.fromFile(docUrl, filename: "upload.jpg"),
      });
      final token = await getToken();
      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        if (token != null) HttpHeaders.authorizationHeader: token,
      };
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } on SocketException {
      throw Exception("No internet connection");
    } on DioError catch (e) {
      throw Exception("Upload failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected upload error: $e");
    }
  }

  // Upload profile photo
  Future<Response> uploadProfilePhoto({
    required String endpoint,
    required String firstName,
    required String lastName,
    required String dob,
    required String phoneNumber,
    required String address,
    required String country,
    required String gender,
    required bool isIreland,
    required String ppsNumber,
    required bool isDrive,
    required int visaTypeId,
    required String profilePicture,
    required bool isRemoteURL,
  }) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }
    try {
      final formData = FormData.fromMap({
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "phoneNumber": phoneNumber,
        "address": address,
        "country": country,
        "gender": gender,
        "isIreland": isIreland,
        "ppsNumber": ppsNumber,
        "isDrive": isDrive,
        "visaTypeId": visaTypeId,
        "profilePicture": isRemoteURL
            ? profilePicture
            : await MultipartFile.fromFile(profilePicture, filename: "upload.jpg"),
      });
      final token = await getToken();
      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        if (token != null) HttpHeaders.authorizationHeader: token,
      };
      final response = await _dio.post(
        endpoint,
        data: formData,
        options: Options(headers: headers),
      );
      return response;
    } on SocketException {
      throw Exception("No internet connection");
    } on DioError catch (e) {
      throw Exception("Upload failed: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected upload error: $e");
    }
  }
}


