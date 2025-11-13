import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Model/JourneyHistory.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:sleeping_beauty_app/Model/JourneyHistoryDetails.dart';
import 'package:intl/intl.dart';

class HistorydetailsScreen extends StatefulWidget {
  final String id;

  const HistorydetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<HistorydetailsScreen> createState() => _HistorydetailsScreennState();
}

class _HistorydetailsScreennState extends State<HistorydetailsScreen> {
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

  final List<Map<String, dynamic>> rewardList = [
    {
      "title": "Rose Tea Refill",
      "date": "14-17 Aug 2025",
      "location": "10% off pastries",
      "usedOn": "15 Aug 2025",
      "pointsSpent": "07:00 - 14:00",
      "pointsEarned": "+150",
      "image": "assets/rose.png",
    },
    {
      "title": "Chocolate Croissant",
      "date": "14-17 Aug 2025",
      "location": "10% off pastries",
      "usedOn": "11 Aug 2025",
      "pointsSpent": "07:00 - 14:00",
      "pointsEarned": "+100",
      "image": "assets/rose.png",
    },
    {
      "title": "Coffee Voucher",
      "date": "14-17 Aug 2025",
      "location": "10% off pastries",
      "usedOn": "06 Aug 2025",
      "pointsSpent": "07:00 - 14:00",
      "pointsEarned": "+120",
      "image": "assets/rose.png",
    },
  ];

  JourneyData? _journeyDetails;

  @override
  void initState() {
    super.initState();
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
                        '${_journeyDetails?.journey.name ?? ""} History',
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/shop.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _journeyDetails?.journey.name ?? "",
                        style: TextStyle(
                          color: App_BlackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: App_PtnView,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        child: Row(
                          children: [
                            Image.asset("assets/gift.png", height: 14, width: 14),
                            const SizedBox(width: 4),
                            Text(
                              "${_journeyDetails?.journey.totalPoi ?? ""} Pts",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: App_BlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 2),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        Text(
                          _journeyDetails?.journey.type ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: App_BlackColor,
                          ),
                        )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
            children: [
              Image.asset("assets/date.png", height: 16, width: 16),
              SizedBox(width: 10),
              Text(
                _journeyDetails?.startedAt != null
                    ? _formatCompactDateRange(
                  _journeyDetails!.startedAt.toLocal(),
                  _journeyDetails!.completedAt?.toLocal(), // allow null
                )
                    : "",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: App_BlackColor,
                ),
              ),

              const Spacer(),
              // Image.asset("assets/locationGray.png", height: 18, width: 18),
              // SizedBox(width: 8),
              // Text(
              //   "Hofgeismar",
              //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
              // ),
              // const Spacer(),
              Image.asset("assets/locationGray.png", height: 18, width: 18),
              SizedBox(width: 8),
              Text(
                "${_journeyDetails?.journey.stops ?? 0} Stop",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: App_BlackColor,
                ),
              ),

            ],
          )),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/newMapView.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),

              ListView.builder(
                itemCount: _journeyDetails?.businesses.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final item = _journeyDetails!.businesses[index];

                  final imageUrl = (item.business.images.isNotEmpty)
                      ? item.business.images.first.url
                      : 'https://via.placeholder.com/100'; // placeholder if no image
                  final companyName = item.business.companyName ?? '';
                  final points = item.business.pointReceive ?? 0;

                  final visitedAt = item.visitedAt;
                  final visitedEndAt = item.visitedEndAt;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: App_WhiteColor,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        companyName,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: App_BlackColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4C07A),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/gift.png", height: 14, width: 14),
                                          const SizedBox(width: 4),
                                          Text(
                                            "$points Pts",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                if (visitedAt != null) ...[
                                  Row(
                                    children: [
                                      Image.asset("assets/newDate.png", height: 14, width: 14),
                                      const SizedBox(width: 5),
                                      Text(
                                        _formatCompactDateRange(
                                          visitedAt.toLocal(),
                                          visitedEndAt?.toLocal(), // use ? to handle null
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: App_BlackColor,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      if (visitedEndAt != null) ...[
                                        Image.asset("assets/time.png", height: 16, width: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${DateFormat('HH:mm').format(visitedAt.toLocal())} – ${DateFormat('HH:mm').format(visitedEndAt.toLocal())}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                      ] else ...[
                                        Image.asset("assets/time.png", height: 16, width: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${DateFormat('HH:mm').format(visitedAt.toLocal())}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],

                                const SizedBox(height: 6),

                                //Placeholder for future info
                                Row(
                                  children: [
                                    Image.asset("assets/pointDisable.png", height: 18, width: 18),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: App_BlackColor,
                                        ),
                                      ),
                                    ),
                                  ],
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


              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Journey Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: App_BlackColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        _buildInfoRow("Total Distance Covered:", "${_journeyDetails?.summary.totalDistanceCovered}"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Total Time Spent :", "${_journeyDetails?.summary.totalTimeSpent}"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Total Points Earned:", "${_journeyDetails?.summary.totalPointsEarned}"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Offers Redeemed:", "${_journeyDetails?.summary.offersRedeemed}"),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Multimedia",
                  style: TextStyle(
                    color: App_DescText,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _journeyDetails?.multimedia?.length ?? 0,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final media = _journeyDetails?.multimedia?[index];
                    final imageUrl = media?.url ?? "";

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                        imageUrl,
                        width: 100,
                        height: 95,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 100,
                          height: 95,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 30),
                        ),
                      )
                          : Container(
                        width: 100,
                        height: 95,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 30),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getJourneyDetails() async {
    EasyLoading.show(status: lngTranslation('Loading...'));
    try {
      final response = await apiService.getRequestWithParam(
        ApiConstants.my_journeys_history_details + widget.id,
        queryParams: {
          '': ""
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {

          final apiResponse = ApiResponse.fromJson(data);

          EasyLoading.dismiss();

          setState(() {

            _journeyDetails = apiResponse.data;
            print("data getJourneyDetails:-- $data");

            // Example of accessing data:
            if (_journeyDetails != null) {
              print("Journey Name: ${_journeyDetails!.journey.name}");
              print("Total Points: ${_journeyDetails!.summary.totalPointsEarned}");
            }
          });
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(data['message']);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(AlertConstants.somethingWrong);
      }
    } catch (e) {
      print("Error fetching journeys history : $e");
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getJourney history List finished");
    }
  }
}


Widget _buildInfoRow(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: App_BlackColor,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: App_BlackColor,
        ),
      ),
    ],
  );
}

String _formatCompactDateRange(DateTime start, [DateTime? end]) {
  if (end == null) {
    // Only start date available
    return DateFormat('MMM d yyyy').format(start);
  }

  final sameDay = start.year == end.year &&
      start.month == end.month &&
      start.day == end.day;

  if (sameDay) {
    return DateFormat('MMM d yyyy').format(start);
  }

  final sameMonth = start.month == end.month;
  final sameYear = start.year == end.year;

  if (sameMonth && sameYear) {
    return "${DateFormat('MMM').format(start)} ${start.day}–${end.day} ${start.year}";
  } else if (sameYear) {
    return "${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d').format(end)} ${start.year}";
  } else {
    return "${DateFormat('MMM d yyyy').format(start)} – ${DateFormat('MMM d yyyy').format(end)}";
  }
}
