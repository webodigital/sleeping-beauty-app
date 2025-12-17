import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:sleeping_beauty_app/Network/Gloabal.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
    // SSL bypass (for development only!)
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Add logging interceptor
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    // Error interceptor for 401 / 403
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
            await clearToken();
            EasyLoading.dismiss();

            // Avoid multiple redirects
            if (navigatorKey.currentState?.canPop() == true) {
              navigatorKey.currentState?.popUntil((route) => route.isFirst);
            }

            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              '/login',
                  (route) => false,
            );
            return; // stop further propagation
          }
          handler.next(e);
        },
      ),
    );
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
      final lang = await loadLng();

      final headers = {
        HttpHeaders.authorizationHeader: token ?? "",
        HttpHeaders.contentTypeHeader: "application/json",
        "languageType": lang
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
    final lang = await loadLng();
    if (token == null) {

      EasyLoading.showInfo("Session expired. Please log in again.");
      Future.delayed(const Duration(seconds: 2), () {
        // throw Exception("Authorization token not found.");
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
              (route) => false,
        );
      });

      throw Exception("Session expired. Please log in again.");
    }

    final headers = {
      HttpHeaders.authorizationHeader: token,
      "languageType": lang
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
      final lang = await loadLng();
      final headers = {
        HttpHeaders.authorizationHeader: token ?? "",
        "languageType": lang
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
  Future<Response> postWithoutTokenRequest(
      String endpoint, Map<String, dynamic> data) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiException(ApiConstants.noInterNet);
    }

    final lang = await loadLng();

    try {
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        "lat": currentLat,
        "long": currentLong,
        "languageType": lang,
      };

      final response = await _dio.post(
        endpoint,
        data: data,
        options: Options(headers: headers),
      );

      return response;

    } on DioException catch (e) {
      print("Dio Error: ${e.response?.data}");

      String errorMessage = "Something went wrong";
      final data = e.response?.data;

      if (data is Map<String, dynamic>) {
        // Handle 'message' key
        final msg = data['message'] ?? data['errors']?['message'];

        if (msg is String) {
          errorMessage = msg;
        } else if (msg is List && msg.isNotEmpty) {
          // Join list elements into a single string
          errorMessage = msg.join("\n");
        }
      }

      throw ApiException(errorMessage);

    } on SocketException {
      throw ApiException("No internet connection");
    } catch (e) {
      throw ApiException("Unexpected error occurred");
    }
  }

  Future<Response> uploadPhoto({
    required String endpoint,
    required String profileImage,
    required String fullName,
  }) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (!isConnected) {
      throw ApiConstants.noInterNet;
    }

    try {
      dynamic profileImageFile;

      if (profileImage.isNotEmpty) {
        if (profileImage.startsWith("http")) {
          //Remote URL — fetch and wrap in MultipartFile
          final response = await http.get(Uri.parse(profileImage));
          if (response.statusCode == 200) {
            final bytes = response.bodyBytes;
            profileImageFile = MultipartFile.fromBytes(
              bytes,
              filename: profileImage.split('/').last,
            );
          } else {
            throw Exception("Failed to download remote file");
          }
        } else {
          //Local file path
          profileImageFile = await MultipartFile.fromFile(
            profileImage,
            filename: profileImage.split('/').last,
          );
        }
      }

      final formData = FormData.fromMap({
        "fullName": fullName,
        if (profileImageFile != null) "profileImage": profileImageFile,
      });

      final token = await getToken();
      final lang = await loadLng();
      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        if (token != null)
          HttpHeaders.authorizationHeader: token,
         "languageType": lang
      };

      final response = await _dio.patch(
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
    final lang = await loadLng();
    if (token == null) throw Exception("Authorization token not found.");

    try {
      final headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: token,
        "languageType": lang
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
      final lang = await loadLng();
      if (token == null) throw Exception("Authorization token not found.");

      final headers = {
        HttpHeaders.authorizationHeader: token,
        HttpHeaders.contentTypeHeader: "application/json",
        "languageType": lang
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
      final lang = await loadLng();
      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        "languageType": lang,
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
      final lang = await loadLng();

      final headers = {
        HttpHeaders.contentTypeHeader: "multipart/form-data",
        "languageType": lang,
        if (token != null)
          HttpHeaders.authorizationHeader: token,

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

  Future<String> loadLng() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('Language') ?? "en"; // default to English

    // Map saved values to language codes
    String code;
    if (saved.toLowerCase().contains("GR") || saved.toLowerCase() == "gr") {
      code = "gr";
    } else {
      code = "en";
    }

    print("lngCode for API header: $code");
    return code;
  }

  Future<Response> deleteRequestWithParam(
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
      final lang = await loadLng();

      final headers = {
        HttpHeaders.authorizationHeader: token ?? "",
        HttpHeaders.contentTypeHeader: "application/json",
        "languageType": lang
      };
      final response = await _dio.delete(
        endpoint,
        data: data ?? {},
        queryParameters: queryParams,
        options: Options(headers: headers),
      );
      return response;
    } on DioError catch (e) {
      throw Exception("Delete request failed: ${e.message}");
      EasyLoading.dismiss();
    } catch (e) {
      throw Exception("Unexpected error: $e");
      EasyLoading.dismiss();
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
