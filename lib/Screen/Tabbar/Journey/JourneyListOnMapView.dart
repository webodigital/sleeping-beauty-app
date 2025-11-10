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

class JourneyListOnMapViewScreen extends StatefulWidget {
  final Journey journey;


  const JourneyListOnMapViewScreen({Key? key, required this.journey}) : super(key: key);


  @override
  State<JourneyListOnMapViewScreen> createState() =>
      _JourneyListOnMapViewState();
}

class _JourneyListOnMapViewState extends State<JourneyListOnMapViewScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.45);
  int _currentPage = 0;

  final List<MapMarker> markers = [
    MapMarker(id: 1, latitude: 21.3012, longitude: 70.2499),
    MapMarker(id: 2, latitude: 21.3022, longitude: 70.2599),
    MapMarker(id: 3, latitude: 21.3032, longitude: 70.2699),
  ];

  final List<Map<String, dynamic>> cardData = List.generate(
    10,
        (index) => {
      "title": "Sababurg Castle",
      "rating": "4.2",
      "reviews": "(24 Reviews)",
      "image": "assets/castle.png", // add your demo image
    },
  );


  @override
  void initState() {
    super.initState();
    getBussinessList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Fullscreen Map View
          CustomMapWidget(
            markers: markers,
            zoom: 6.5,
            initialCenter: const LatLng(21.3012, 70.2499),
            onPinTap: (id) {
              debugPrint("Tapped marker: $id");
              showJourneyPopup(context);
            },
          ),

          //Header (floating on top of map)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                // decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.85),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/backArrow.png", height: 26, width: 26),
                    const SizedBox(width: 10),
                    Text(
                      lngTranslation('Journey'),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: App_BlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Cards Overlay
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
                    itemCount: cardData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final item = cardData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: App_WhiteColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color:App_BlackColor,
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
                                child: Image.asset(
                                  item["image"],
                                  height: 75,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  item["title"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: App_BlackColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 6, right: 8),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 14, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(
                                      "${item["rating"]}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: App_BlackColor,
                                      ),
                                    ),
                                    Text(
                                      " ${item["reviews"]}",
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
                      );
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // Dots Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    cardData.length,
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

  void showJourneyPopup(BuildContext context) {
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
                  imageUrl: 'assets/castle.png',
                  title: 'The Sleeping Beauty Castle',
                  subtitle: 'Sababurg Castle',
                  description: 'Built in 1334, this castle has enchanted travelers for centuries. It is widely believed to have inspired the Brothers Grimm when writing the famous Sleeping Beauty tale.',
                  rating: 4.8,
                  reviews: 243,
                  points: 120,
                  onViewDetails: () {
                    Navigator.pop(context);
                    print("on click view details");
                    // handle view details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const JourneyDetailsScreen(title: 'Wellness Journey', imagePath: 'assets/wellness.png'),
                      ),
                    );
                  },
                  onVisit: () {
                    Navigator.pop(context);
                    // handle visit
                    print("on click Visit");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const JourneyVisitRootOnMapScreen(title: 'Wellness Journey', imagePath: 'assets/wellness.png'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> getBussinessList() async {
    EasyLoading.show(status: lngTranslation('Loading...'));
    try {
      final response = await apiService.getRequestWithParam(ApiConstants.businesses_by_location ,
        queryParams: {
          'page': "1",
          'limit': "100",
          'lat': "20.8009",
          'lng': "70.6960",
          'radiusKm': "1000",
          'journeyId': widget.journey.id,
      },);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        print("Response Data:- $data");

        if (data['success'] == true) {

          EasyLoading.dismiss();
          setState(() {

          });
        } else {
          EasyLoading.dismiss();
          String errorMessage = data['message'] ?? lngTranslation('Something went wrong please try again');
          EasyLoading.showError(errorMessage);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Server Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print("Error fetching journeys: $e");
      print(stackTrace);
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getJourneyList finished");
    }
  }
}

// Model for map markers
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

//Custom map widget (for demo only)
class CustomMapWidget extends StatelessWidget {
  final List<MapMarker> markers;
  final double zoom;
  final LatLng? initialCenter;
  final Function(int id)? onPinTap;

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
                onTap: () => onPinTap?.call(marker.id),
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
    return Center(
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.all(16),
        shadowColor: App_BlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: 360,
          padding: const EdgeInsets.only(top: 16, left: 12,right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: App_WhiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image with Points Badge
              Stack(
                children: [
                  // Background Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
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
                        // Handle heart tap here
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

              // Title
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                description,
                style: TextStyle(
                  color: App_BlackColor,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 10),

              /// Buttons
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
                        lngTranslation("View Details"),
                        style: TextStyle(
                          color: App_BlackColor,
                          fontWeight: FontWeight.w500,
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
                        backgroundColor: App_Start_Now,
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
