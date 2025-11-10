import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/HistoryDetails.dart';
import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';

class MyjourneyhistoryScreen extends StatefulWidget {
  const MyjourneyhistoryScreen({Key? key}) : super(key: key);

  @override
  State<MyjourneyhistoryScreen> createState() => _MyjourneyhistoryScreenState();
}

class _MyjourneyhistoryScreenState extends State<MyjourneyhistoryScreen> {
  final Color App_BlackColor = const Color(0xFF1C1C1C);
  final Color App_Card_View = Colors.white;

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

        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return InkWell(
              borderRadius: BorderRadius.circular(18), // smooth ripple
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistorydetailsScreen()),
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
                                      "Romantic Journey",
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
                                            "+100 Pts",
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
                                  SizedBox(width: 10),
                                  Text(
                                    "14–17 Aug 2025",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
                                  ),
                                  SizedBox(width: 22),
                                  Image.asset("assets/time.png", height: 14, width: 14),
                                  SizedBox(width: 8),
                                  Text(
                                    "07:00 – 14:00",
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/locationGray.png", height: 14, width: 14),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "WachsLiebe Studio Heidelberg, Germany",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: App_BlackColor,
                                        height: 1.3,
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
}