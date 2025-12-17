
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlertConstants {


  static const String userNameBlank = "Please enter your full name";
  static const String emailBlank = "Please enter your email";
  static const String emailInvalid = "Please enter a valid email address";
  static const String passwordBlank = "Please enter your password";
  static const String somethingWrong = "Something went wrong";
  static const String profileUploadfailed = "Profile upload failed";
  static const String profilePhoto = "Please select profile photo";
  static const String profileValidation = "Password must be at least 6 characters long";
  static const String signUpDoneLogin = "You're in! Time to log in and explore.";
  static const String noBussiness = "Looks like there are no businesses in this journey yet!";


  static const String noInterNet = "No internet connection. Please check your network settings and try again.";
}


Future<String?> getUserLocation() async {
  try {
    Position position = await _getCurrentPosition();
    String city = await getCityName(position.latitude, position.longitude);

    print('Latitude: ${position.latitude}');
    print('Longitude: ${position.longitude}');
    print('City: $city');

    return city;
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<Position> _getCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // Check permission
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, cannot request permissions.');
  }

  // Get current position
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}

Future<String> getCityName(double latitude, double longitude) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
  Placemark place = placemarks.first;
  return place.locality ?? 'Unknown city';
}

Future<bool> getIsUserLogin() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('is_userLogin') ?? false;
}

Future<void> updateUserLogin(bool isUserLogin) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('is_userLogin', isUserLogin);
}