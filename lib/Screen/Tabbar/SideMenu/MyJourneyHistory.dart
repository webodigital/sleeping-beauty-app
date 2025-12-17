import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/HistoryDetails.dart';
import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Model/JourneyHistory.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:intl/intl.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MyjourneyhistoryScreen extends StatefulWidget {
  const MyjourneyhistoryScreen({Key? key}) : super(key: key);

  @override
  State<MyjourneyhistoryScreen> createState() => _MyjourneyhistoryScreenState();
}

class _MyjourneyhistoryScreenState extends State<MyjourneyhistoryScreen> {


  List<UserJourney> journyHistoryList = [];

  @override
  void initState() {
    super.initState();
    getJourneyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
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
                        lngTranslation('My Journey History'),
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

              const SizedBox(height: 10),

              journyHistoryList.isEmpty
                  ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 250, horizontal: 20),
                  child: Center(
                    child: Text(
                      lngTranslation("Start exploring — your first journey awaits!"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: App_BlackColor,
                      ),
                    ),
                  ),
                ),
              )
                  :  ListView.builder(
          itemCount: journyHistoryList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {

            var data = journyHistoryList[index];

            return InkWell(
              borderRadius: BorderRadius.circular(18), // smooth ripple
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistorydetailsScreen(id: data.id ?? "",)),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: App_Card_View,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, top: 15, right: 10, bottom: 15),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/romanticJourney.png",
                            height: 46,
                            width: 46,
                            color: Colors.grey.shade400,
                          ),
                        ),

                        Container(
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 9),
                          color: App_Devider.withOpacity(0.20),
                        ),

                        const SizedBox(width: 4),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      data.journey?.name ?? "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: App_BlackColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
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
                                            "+${data.journey?.totalPoints.toString() } ${lngTranslation("Pts")}",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: App_BlackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Image.asset("assets/date.png", height: 14, width: 14),
                                  const SizedBox(width: 10),
                                  Text(
                                    _formatCompactDateRange(DateTime.parse(data.startedAt!).toLocal(), DateTime.parse(data.completedAt!).toLocal()),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                  const SizedBox(width: 22),
                                  Image.asset("assets/time.png", height: 14, width: 14),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${DateFormat('HH:mm').format(DateTime.parse(data.startedAt!).toLocal())} – ${DateFormat('HH:mm').format(DateTime.parse(data.completedAt!).toLocal())}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 15),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Image.asset("assets/locationGray.png", height: 14, width: 14),
                              //     SizedBox(width: 10),
                              //     Expanded(
                              //       child: Text(
                              //         "WachsLiebe Studio Heidelberg, Germany",
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w400,
                              //           color: App_BlackColor,
                              //           height: 1.3,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
        ],
          ),
        ),
      ),
    );
  }


  Future<void> getJourneyList() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: lngTranslation('Loading...'));
    try {
      final response = await apiService.getRequestWithParam(
        ApiConstants.my_journeys_history ,
        queryParams: {
          'limit': "100",
          'page': "1"
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          final journeysResponse = UserJourneysResponse.fromJson(data);
          EasyLoading.dismiss();
          setState(() {
            journyHistoryList = journeysResponse.data?.data ?? [];
          });
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(data['message'] ?? 'Something went wrong');
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

String _formatCompactDateRange(DateTime start, DateTime end) {
  final sameDay = start.year == end.year &&
      start.month == end.month &&
      start.day == end.day;

  if (sameDay) {
    // Example: Nov 12 2025
    return "${DateFormat('MMM d yyyy').format(start)}";
  }

  final sameMonth = start.month == end.month;
  final sameYear = start.year == end.year;

  if (sameMonth && sameYear) {
    // Example: Nov 12–15 2025
    return "${DateFormat('MMM').format(start)} ${start.day}–${end.day} ${start.year}";
  } else if (sameYear) {
    // Example: Nov 30 – Dec 2 2025
    return "${DateFormat('MMM d').format(start)} – ${DateFormat('MMM d').format(end)} ${start.year}";
  } else {
    // Example: Dec 30 2025 – Jan 2 2026
    return "${DateFormat('MMM d yyyy').format(start)} – ${DateFormat('MMM d yyyy').format(end)}";
  }
}

