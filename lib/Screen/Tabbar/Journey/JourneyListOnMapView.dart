import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/MapView.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/VisitJournyMapview.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/JourneyDetails.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Model/JourneyList.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Model/BussinesListOfJourney.dart';
import 'package:sleeping_beauty_app/Model/OnGoingJourny.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class JourneyListOnMapViewScreen extends StatefulWidget {
  final Journey? journey;
  final bool isFromJourneyScreen;
  final String journeyID;
  final String journeyName;


  const JourneyListOnMapViewScreen({Key? key, required this.journey, required this.isFromJourneyScreen, required this.journeyID, required this.journeyName}) : super(key: key);

  @override
  State<JourneyListOnMapViewScreen> createState() =>
      _JourneyListOnMapViewState();
}

class _JourneyListOnMapViewState extends State<JourneyListOnMapViewScreen> {

  JourneyResponse? ongoingJourneyResponse;
  JourneyData? ongoingJourneyData;

  BusinessResponse? businessResponse;

  final PageController _pageController = PageController(viewportFraction: 0.45);
  int _currentPage = 0;

  List<MapMarker> markers = [];

  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();

    _fetchCurrentLocation();
    getOngoingJourneyList();
  }

  Future<void> _fetchCurrentLocation() async {
    Position position = await getCurrentLocation(); // your async function
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      print('_fetchCurrentLocation: latitude ${_currentPosition?.latitude}');
      print('_fetchCurrentLocation: longitude ${_currentPosition?.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Fullscreen Map View
          CustomMapWidget(
            markers: markers,
            zoom: 10,
            initialCenter: _currentPosition,
            onPinTap: (markerId) {
              debugPrint("Tapped marker: $markerId");

              // Find the matching business from businessResponse
              final matchedBusiness = businessResponse?.data.firstWhere(
                    (b) => b.id.toString() == markerId
              );

              if (matchedBusiness != null) {
                showJourneyPopup(context, matchedBusiness);
              } else {
                debugPrint("No matching business found for marker $markerId");
              }
            },
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

                    if ((ongoingJourneyResponse?.data?.journeyId ?? "").isNotEmpty) {
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
                                    lngTranslation("End Journey"),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    lngTranslation("Are you sure you want to end this journey?"),
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
                                            Navigator.of(context).pop();
                                            completeJourney(widget.isFromJourneyScreen ? widget.journeyID : widget.journey?.id ?? "");
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
                                            lngTranslation("End Journey"),
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
                    }else{
                      Navigator.of(context).pop();
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/backArrow.png", height: 26, width: 26),
                      const SizedBox(width: 10),
                      Text(
                        widget.isFromJourneyScreen
                            ? widget.journeyName
                            : ((widget.journey?.name.isNotEmpty ?? false)
                            ? "${widget.journey!.name}"
                            : lngTranslation("Journey")),
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
            bottom: 30,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 130,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: businessResponse?.data.length ?? 0,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = businessResponse?.data[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            debugPrint("Clicked index: $index");
                            debugPrint("Business: ${item?.companyName}");
                            debugPrint("Full object: ${item?.toJson()}");
                            final matchedBusiness = businessResponse?.data[index];

                            if (matchedBusiness != null) {
                              showJourneyPopup(context, matchedBusiness);
                            } else {
                              debugPrint("No matching business found forclick bottom card");
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: App_WhiteColor,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: App_BlackColor,
                                  blurRadius: 0,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    (item?.images != null && item!.images!.isNotEmpty)
                                        ? item!.images!.first.url
                                        : "https://placehold.co/600x400.png?text=No+Image",
                                    height: 75,
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Text(
                                    item?.companyName ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 8, bottom: 6, right: 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/start.png',
                                        width: 14,
                                        height: 14,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "4.2",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: App_BlackColor,
                                        ),
                                      ),
                                      Text(
                                        " (244 Reviews)",
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: App_BlackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    businessResponse?.data.length ?? 0,
                        (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.brown
                            : Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showJourneyPopup(BuildContext context, Business data) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: App_BlackColor.withOpacity(0.3), // optional dim background
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: GestureDetector(
                onTap: () {},
                child: JourneyPopupCard(
                  imageUrl: (data?.images != null && data!.images!.isNotEmpty)
                      ? data!.images!.first.url
                      : "https://placehold.co/600x400.png?text=No+Image",
                  title: data.companyName,
                  subtitle: data.companyName,
                  description: data.shortDescription,
                  rating: 4.8,
                  reviews: 243,
                  points: data.pointEarn ?? 0,
                  onViewDetails: () {
                    Navigator.pop(context);
                    print("on click view details");
                    // handle view details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JourneyDetailsScreen(id: data.id.toString(), journyName:  widget.isFromJourneyScreen
                            ? "" : "${widget.journey!.name}"),
                      ),
                    );
                  },
                  onVisit: () {
                    Navigator.pop(context);
                    // handle visit
                    print("on click Visit :-- ${data.id}");
                    startBusinessJourny(data.id, data);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getBusinessList() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: lngTranslation('Loading...'));
    Position currentPosition = await getCurrentLocation();

    try {
      final response = await apiService.getRequestWithParam(
        ApiConstants.businesses_by_location,
        queryParams: {
          'page': "1",
          'limit': "100",
          'lat': currentPosition.latitude,
          'lng': currentPosition.longitude,
          'radiusKm': "1000",
          'journeyId':  widget.isFromJourneyScreen ? widget.journeyID : widget.journey?.id ?? "",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        print("Response Data:- $data");

        if (data['success'] == true) {

          businessResponse = BusinessResponse.fromJson(data);

          EasyLoading.dismiss();
          setState(() {
            // now you can access businessResponse anywhere in this widget
            // print("First business: ${businessResponse!.data[0].companyName}");
            businessResponse = BusinessResponse.fromJson(data);

            if (businessResponse?.data.isEmpty == true){
              EasyLoading.showError(AlertConstants.noBussiness);
            }

            Future.delayed(const Duration(seconds: 2), () {
              if (businessResponse != null) {
                updateMarkersFromData(businessResponse!);
                setState(() {});
              }
            });
          });
        } else {
          EasyLoading.dismiss();
          String errorMessage =
              data['message'] ?? lngTranslation(AlertConstants.somethingWrong);
          EasyLoading.showError(errorMessage);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(AlertConstants.somethingWrong);
      }
    } catch (e, stackTrace) {
      print("Error fetching businesses: $e");
      print(stackTrace);
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getBusinessList finished");
    }
  }

  void updateMarkersFromData(BusinessResponse businessResponse) {
    markers = businessResponse.data.map((business) {
      return MapMarker(
        id: business.id,
        latitude: business.gpsCoordinates.lat,
        longitude: business.gpsCoordinates.lng,
      );
    }).toList();
  }

  Future<void> startBusinessJourny(String businessId, Business business) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: 'Loading...');
    Position currentPosition = await getCurrentLocation();

    print("------------------");

    try {
      final response = await apiService.postRequest(
        ApiConstants.user_start_journey,
        {
          "journeyId": widget.isFromJourneyScreen
              ? widget.journeyID
              : widget.journey?.id,
          "businessId": businessId,
          "sourceGPS": {
            "lat": currentPosition.latitude,
            "lng": currentPosition.longitude,
          },
        },
      );

      final responseData = response.data;

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          (responseData['success'] == true || responseData['status'] == "success")) {
        print("Started journey successfully");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JourneyVisitRootOnMapScreen(
              isFromJourneyScreen: false,
              journeyData: null,
              businessData: business,
              journyName: widget.isFromJourneyScreen
            ? "" : "${widget.journey!.name}",
            ),
          ),
        ).then((result) {

          debugPrint("Returned from JourneyVisitRootOnMapScreen");
          getOngoingJourneyList();
        });
      } else {
        final errorMessage = responseData['message'] ?? "Something went wrong.";
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      print("Error in startBusinessJourny: $e");
      EasyLoading.showError(lngTranslation(AlertConstants.somethingWrong));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> completeJourney(String journeyID) async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: 'Loading...');

    print("journeyID:- $journeyID");

    try {
      final response = await apiService.patchRequestWithParam(
        ApiConstants.user_journeys_completed + journeyID + "/complete",
        body: {
          "": ""
        },
      );

      final data = response.data;

      print("data:-- $data");

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          (data['success'] == true || data['status'] == "success")) {
        EasyLoading.showSuccess(data['message'] ?? "");
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });

        // If you want to refresh job list after request:
        // await fetchJobList();
      } else {
        final errorMessage = data['message'] ?? "";
        EasyLoading.showError(errorMessage);
      }
    } catch (e) {
      EasyLoading.showError("${e.toString()}");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getOngoingJourneyList() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);

      return;
    }
    EasyLoading.show(status: lngTranslation('Loading...'));

    try {
      final response = await apiService.getRequest(ApiConstants.user_journeys_ongoing);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {

          ongoingJourneyResponse = JourneyResponse.fromJson(data);
          ongoingJourneyData = ongoingJourneyResponse?.data;

          // Print for debug
          print("Journey fetched successfully");

          EasyLoading.dismiss();

        } else {
          EasyLoading.dismiss();
        }

      } else {
        EasyLoading.dismiss();
      }

    } catch (e, stackTrace) {
      print("Error fetching journeys: $e");
      EasyLoading.dismiss();
    } finally {
      print("getOngoingJourneyList finished");
      getBusinessList();
    }
  }
}

// Model for map markers
class MapMarker {
  final String id;
  final double longitude;
  final double latitude;

  MapMarker({
    required this.id,
    required this.latitude,
    required this.longitude,
  });
}

//Custom map widget (for demo only)
class CustomMapWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final double zoom;
  final LatLng? initialCenter;
  final Function(String id)? onPinTap;

  const CustomMapWidget({
    super.key,
    required this.markers,
    this.zoom = 12,
    this.initialCenter,
    this.onPinTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter ?? const LatLng(0, 0),
        initialZoom: zoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.custommap',
        ),
        MarkerLayer(
          markers: markers.map((marker) {
            final LatLng pos = LatLng(marker.latitude, marker.longitude);
            return Marker(
              point: pos,
              width: 60,
              height: 60,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () => onPinTap?.call(marker.id.toString() ?? ""),
                child: Image.asset(
                  "assets/pinStr.png",
                  width: 30,
                  height: 30,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class JourneyPopupCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String description;
  final double rating;
  final int reviews;
  final int points;
  final VoidCallback onViewDetails;
  final VoidCallback onVisit;

  const JourneyPopupCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.rating,
    required this.reviews,
    required this.points,
    required this.onViewDetails,
    required this.onVisit,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the content width inside the Card
    const double cardWidth = 360;
    const double horizontalPadding = 12;
    const double contentWidth = cardWidth - (horizontalPadding * 2);

    return Center(
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.all(16),
        shadowColor: App_BlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: cardWidth, // 360
          padding: const EdgeInsets.only(top: 16, left: horizontalPadding, right: horizontalPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: App_WhiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // --- Image Stack Section ---
              Stack(
                children: [
                  // Background Image
                  SizedBox(
                    width: contentWidth, // 360 - 24 = 336
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        // The height property here is now redundant but harmless;
                        // the parent SizedBox provides the strict constraint.
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  // Points Badge (Top Left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: App_PtnView,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/gift.png', height: 20, width: 19),
                          const SizedBox(width: 4),
                          Text(
                            "+$points Pts",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: App_BlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Heart Button (Top Right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        print("Heart tapped!");
                      },
                      child: Container(
                        child: Image.asset('assets/heartUnfill.png', height: 26, width: 26),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // --- Subtitle and Ratings ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      subtitle,
                      style:  TextStyle(
                        color:App_BlackColor.withAlpha(100),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset('assets/start.png', height: 15, width: 15),
                      const SizedBox(width: 4),
                      Text(
                        "$rating",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "($reviews Reviews)",
                        style: TextStyle(
                          color: App_BlackColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // --- Title ---
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              // --- Description ---
              Text(
                description,
                style: TextStyle(
                  color: App_BlackColor,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 10),

              /// --- Buttons ---
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onViewDetails,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: App_Start_Now,width: 2),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        // NOTE: Assuming lngTranslation is defined globally or passed in
                        lngTranslation("View Details"),
                        style: TextStyle(
                            color: App_BlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onVisit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: App_UsedView,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        lngTranslation("Visit"),
                        style: TextStyle(
                            color: App_BlackColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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
