import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sleeping_beauty_app/Model/OnGoingJourny.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Model/BussinesListOfJourney.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class JourneyVisitRootOnMapScreen extends StatefulWidget {
  final bool isFromJourneyScreen;
  final JourneyData? journeyData;
  final Business? businessData;
  final String journyName;

  const JourneyVisitRootOnMapScreen({
    Key? key,
    this.isFromJourneyScreen = false,
    this.journeyData,
    this.businessData,
    this.journyName = "",
  }) : super(key: key);

  @override
  State<JourneyVisitRootOnMapScreen> createState() => _JourneyVisitRootOnMapScreenState();
}

class _JourneyVisitRootOnMapScreenState
    extends State<JourneyVisitRootOnMapScreen> {

  StreamSubscription<Position>? positionStream;


  GoogleMapController? _mapController;

  final List<MapMarker> markers = [
    MapMarker(id: 1, latitude: 22.3039, longitude: 70.8022),
  ];

  final Set<Marker> _googleMarkers = {};
  final Set<Polyline> _polylines = {};
  late PolylinePoints polylinePoints;

  LatLng? _currentPosition;
  bool _isLoadingLocation = true;

  String? _currentAddress;

  var businessesLat = 0.0;
  var businessesLong = 0.0;

  @override
  void initState() {
    super.initState();

    markers.removeAt(0);

    businessesLat = widget.isFromJourneyScreen ? widget.journeyData?.businesses.first.business?.gpsCoordinates?.lat ?? 0.0 : widget.businessData?.gpsCoordinates.lat ?? 0.0;
    businessesLong = widget.isFromJourneyScreen ? widget.journeyData?.businesses.first.business?.gpsCoordinates?.lng ?? 0.0 : widget.businessData?.gpsCoordinates.lng ?? 0.0;

    markers.add(MapMarker(id: 1, latitude: businessesLat, longitude: businessesLong));
    polylinePoints = PolylinePoints();

    _setupMarkers();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }


  void _setupMarkers() {
    for (var m in markers) {
      _googleMarkers.add(Marker(
        markerId: MarkerId(""),
        position: LatLng(businessesLat ,businessesLong),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    // Get initial location
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _currentPosition = LatLng(position.latitude, position.longitude);

    await _getAddressFromLatLng(_currentPosition!);

    setState(() => _isLoadingLocation = false);

    // Add marker
    _googleMarkers.add(
      Marker(
        markerId: const MarkerId("current_location"),
        position: _currentPosition!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition!, 13.5),
    );

    // Draw first route
    _drawRoute();

    // START LIVE LOCATION UPDATES
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 20, // update every 20 meters
      ),
    ).listen((Position newPos) {
      _currentPosition = LatLng(newPos.latitude, newPos.longitude);

      // Update current location marker
      setState(() {
        _googleMarkers.removeWhere((m) => m.markerId == const MarkerId("current_location"));
        _googleMarkers.add(
          Marker(
            markerId: const MarkerId("current_location"),
            position: _currentPosition!,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });

      // Move camera
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_currentPosition!),
      );

      // Re-draw route from new position
      _drawRoute();
    });
  }



  // Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     await Geolocator.openLocationSettings();
  //     return;
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) return;
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) return;
  //
  //   final position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //   _currentPosition = LatLng(position.latitude, position.longitude);
  //
  //   await _getAddressFromLatLng(_currentPosition!);
  //
  //   setState(() {
  //     _isLoadingLocation = false;
  //   });
  //
  //   // Add current location marker
  //   _googleMarkers.add(Marker(
  //     markerId: const MarkerId("current_location"),
  //     position: _currentPosition!,
  //     infoWindow: const InfoWindow(title: "You are here"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   ));
  //
  //   // Move camera
  //   _mapController?.animateCamera(
  //     CameraUpdate.newLatLngZoom(_currentPosition!, 13.5),
  //   );
  //
  //   // Draw route to destination
  //   _drawRoute();
  // }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        _currentAddress =
        "${p.locality ?? ''}, ${p.administrativeArea ?? ''}, ${p.country ?? ''}";
      }
    } catch (e) {
      debugPrint("Error in reverse geocoding: $e");
    }
  }

  Future<void> _drawRoute() async {
    if (_currentPosition == null) return;

    final origin = PointLatLng(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    final destination = PointLatLng(
      markers[0].latitude,
      markers[0].longitude,
    );

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: ApiConstants.googleApiKey,
      request: PolylineRequest(
        origin: origin,
        destination: destination,
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      final routeCoords = result.points
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList();

      setState(() {
        _polylines.clear(); // IMPORTANT for live updates
        _polylines.add(
          Polyline(
            polylineId: const PolylineId('route'),
            color: Colors.blueAccent,
            width: 5,
            points: routeCoords,
          ),
        );
      });
    }
  }


  // Future<void> _drawRoute() async {
  //   if (_currentPosition == null) return;
  //
  //   final origin =
  //   PointLatLng(_currentPosition!.latitude, _currentPosition!.longitude);
  //   final destination =
  //   PointLatLng(markers[0].latitude, markers[0].longitude);
  //
  //   final result = await polylinePoints.getRouteBetweenCoordinates(
  //     googleApiKey: ApiConstants.googleApiKey,
  //     request: PolylineRequest(
  //       origin: origin,
  //       destination: destination,
  //       mode: TravelMode.driving,
  //     ),
  //   );
  //
  //   if (result.points.isNotEmpty) {
  //     final routeCoords =
  //     result.points.map((p) => LatLng(p.latitude, p.longitude)).toList();
  //
  //     setState(() {
  //       _polylines.add(Polyline(
  //         polylineId: const PolylineId('route'),
  //         color: Colors.blueAccent,
  //         width: 5,
  //         points: routeCoords,
  //       ));
  //     });
  //   } else {
  //     debugPrint("No route found: ${result.errorMessage}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _isLoadingLocation
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
              if (_currentPosition != null) {
                _mapController!.animateCamera(
                  CameraUpdate.newLatLngZoom(_currentPosition!, 13.5),
                );
              }
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? const LatLng(21.5, 70.75),
              zoom: 13.5,
            ),
            mapType: MapType.normal,
            markers: _googleMarkers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // User must choose an action
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(
                                   lngTranslation("End Visit"),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: App_BlackColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                 Text(
                                   lngTranslation("Are you sure you want to end this visit?"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: App_BlackColor,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height:40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // Close dialog
                                        },
                                        style: OutlinedButton.styleFrom(
                                          side: const BorderSide(color: Colors.grey),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding:
                                          const EdgeInsets.symmetric(vertical: 14),
                                        ),
                                        child: Text(
                                          lngTranslation("Cancel"),
                                          style: TextStyle(
                                            color: App_BlackColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close dialog

                                          var id = widget.isFromJourneyScreen ? widget.journeyData?.businesses.first.business?.id ?? "" : widget.businessData?.id ?? "";

                                          completeVisit(id);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding:
                                          const EdgeInsets.symmetric(vertical: 14),
                                        ),
                                        child: Text(
                                          lngTranslation("End Visit"),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: App_WhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/backArrow.png", height: 26, width: 26),
                      const SizedBox(width: 10),
                      Text(
                        widget.journyName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: App_BlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 60,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.circle, size: 12, color: Colors.grey),
                      Container(
                        width: 2,
                        height: 24,
                        color: Colors.grey.shade300,
                      ),
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lngTranslation("Your Location"),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _currentAddress ?? lngTranslation("Fetching current location..."),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lngTranslation("Destination Location"),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                         widget.isFromJourneyScreen ? widget.journeyData?.businesses.first.business?.address  ?? "" : widget.businessData?.address ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> completeVisit(
      String businessID) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: lngTranslation('Loading...'));

    try {

      Position currentPosition = await getCurrentLocation();

      final body = {
        "distance": "2.5",
        "destinationGPS": {
          "lat": currentPosition.latitude,
          "lng": currentPosition.longitude,
        }
      };

      final response = await apiService.patchRequestWithParam(
        ApiConstants.user_journeys_business_complete + businessID + "/complete",
        body: body,
      );

      final data = response.data;
      print("data:-- $data");

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          (data['success'] == true || data['status'] == "success")) {
        EasyLoading.showSuccess(data['message'] ?? "");
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      } else {
        final errorMessage = data['message'] ?? lngTranslation(AlertConstants.somethingWrong);
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError(lngTranslation(AlertConstants.somethingWrong));
    } finally {
      EasyLoading.dismiss();
    }
  }
}

class MapMarker {
  final int id;
  final double latitude;
  final double longitude;

  MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
  });
}

Future<Position> getCurrentLocation() async {
  // Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, request user to enable them
    return Future.error('Location services are disabled.');
  }

  // Check for permission
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}