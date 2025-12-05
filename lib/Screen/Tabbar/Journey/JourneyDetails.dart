import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';

import 'package:sleeping_beauty_app/Model/Details.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class JourneyDetailsScreen extends StatefulWidget {
  final String id;
  final String journyName;

  const JourneyDetailsScreen({
    Key? key,
    required this.id,
    required this.journyName,
  }) : super(key: key);

  @override
  State<JourneyDetailsScreen> createState() => _JourneyDetailsScreenState();
}

class _JourneyDetailsScreenState extends State<JourneyDetailsScreen> {


  BusinessDetailResponse? businessDetailResponse;
  Business? businessDetail;

  final List<String> mediaImages = [
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
    'assets/shop.png',
  ];

  final List<Map<String, String>> offers = [
    {
      "title": "10% OFF your romantic pastry set",
      "subtitle": "Code: LOVE10 (valid today only)",
    },
    {
      "title": "Buy 2 pastries, get 1 mini tart free",
      "subtitle": "Show this offer to the cashier at checkout\nCode: TREATME (Today until 6:00)",
    }
  ];

  @override
  void initState() {
    super.initState();
    print("initState:- JourneyDetailsScreen");
    getJourneyDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/backArrow.png", height: 26, width: 26),
                      const SizedBox(width: 10),
                      Text(
                          widget.journyName ?? "",
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (businessDetail?.images != null &&
                  businessDetail!.images!.isNotEmpty &&
                  businessDetail!.images!.first.url.isNotEmpty)
                  ? Image.network(
                businessDetail!.images!.first.url,
                height: 190,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
                  : Image.asset(
                'assets/banner.png',
                height: 190,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        businessDetail?.companyName ?? "",
                        style: TextStyle(
                          color: App_BlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset('assets/locationPin.png', height: 15, width: 15),
                        const SizedBox(width: 6),
                         Text("${businessDetail?.distance ?? 0} Km",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/disableLocation.png', height: 18, width: 18),
                        const SizedBox(width: 4),
                        Text(
                          businessDetail?.address ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: App_Location,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/start.png', height: 15, width: 15),
                        const SizedBox(width: 6),
                        const Text(
                          "4.2",
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lngTranslation("Description"),
                      style: TextStyle(
                        color: App_DescText,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      businessDetail?.shortDescription ?? "",
                      style: TextStyle(
                        color: App_BlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  lngTranslation("Multimedia"),
                  style: TextStyle(
                    color: App_DescText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: businessDetail?.images?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        height: 70,
                        businessDetail?.images?[index].url ?? "",
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  lngTranslation("Opening Hours"),
                  style: TextStyle(
                    color: App_DescText,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    (businessDetail?.regularOpeningHours ?? "").replaceAll(", ", "\n"),
                    style: TextStyle(
                      color: App_BlackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      height: 2,
                    ),
                  ),
              ),
              const SizedBox(height: 18),

      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if (businessDetail?.discounts?.isEmpty == false)...[
            Text(
              lngTranslation("Offers"),
              style: TextStyle(
                color: App_BlackColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),

            // List of Offers
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: businessDetail?.discounts?.length ?? 0,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final offer = businessDetail?.discounts?[index] ?? "";

                String mainText = offer;
                String codeText = "";
                String extraText = "";

                if (offer.contains("Code:")) {
                  final parts = offer.split("Code:");
                  mainText = parts[0].trim();
                  final codeParts = parts[1].split("-");
                  codeText = codeParts[0].trim();
                  extraText = codeParts.length > 1 ? "- ${codeParts[1].trim()}" : "";
                }

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("assets/discount.png", height: 32, width: 32),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mainText,
                              style: TextStyle(
                                color: App_BlackColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: App_DescText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  height: 1.3,
                                ),
                                children: [
                                  if (codeText.isNotEmpty) ...[
                                    const TextSpan(text: "Code: "),
                                    TextSpan(
                                      text: codeText,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600, // bold only code
                                      ),
                                    ),
                                  ],
                                  if (extraText.isNotEmpty)
                                    TextSpan(text: " $extraText"), // rest of text
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // centers vertically
              children: [
                Image.asset("assets/coin.png", height: 32, width: 32),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    "You will Earn ${businessDetail?.pointEarn ?? 0} Points by visiting there",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: App_BlackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getJourneyDetails() async {

    EasyLoading.show(status: lngTranslation('Loading...'));

    Position position = await _getCurrentPosition();

    print(" widget.id:-- ${ widget.id}");

    try {
      final response = await apiService.getRequestWithParam(
        ApiConstants.businesses_details_id + widget.id,
        queryParams: {
          'lat': position.latitude,
          'lng': position.longitude
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          EasyLoading.dismiss();

          setState(() {
            businessDetailResponse = BusinessDetailResponse.fromJson(data);
            businessDetail = businessDetailResponse?.data?.business;
          });

        } else {
          EasyLoading.dismiss();
          String errorMessage = data['message'] ??
              lngTranslation('Something went wrong please try again');
          EasyLoading.showError(errorMessage);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Server Error: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching journey details: $e");
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getJourneyDetails finished");
    }
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