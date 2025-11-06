import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';

class HistorydetailsScreen extends StatefulWidget {

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
                        'Romentic Journey History',
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
                        "Bäckerei Herzstück",
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
                          "Romantic",
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
                "14–17 Aug 2025",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
              ),
              const Spacer(),
              Image.asset("assets/locationGray.png", height: 18, width: 18),
              SizedBox(width: 8),
              Text(
                "Hofgeismar",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
              ),
              const Spacer(),
              Image.asset("assets/locationGray.png", height: 18, width: 18),
              SizedBox(width: 8),
              Text(
                "6 Stop",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: App_BlackColor),
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
                itemCount: rewardList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final item = rewardList[index];

                  return Stack(
                    children: [
                      Container(
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
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item["image"],
                                  width: 80,
                                  height: 70,
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
                                  Text(
                                    item["title"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4C07A),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    child: Row(
                                      children: [
                                        Image.asset("assets/gift.png", height: 14, width: 14),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${item["pointsEarned"]} Pts",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),

                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image.asset("assets/date.png", height: 13, width: 13),
                                        const SizedBox(width: 5),
                                        Text(
                                          item["date"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset("assets/time.png",
                                            height: 16, width: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          "${item["pointsSpent"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image.asset("assets/pointDisable.png", height: 13, width: 13),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            item["location"],
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
                      ),
                    ],
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
                        _buildInfoRow("Total Distance Covered:", "12.5 km"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Total Time Spent :", "9 hrs 30 min"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Total Points Earned:", "180 pts"),
                        const SizedBox(height: 4),
                        _buildInfoRow("Offers Redeemed:", "3"),
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
                  itemCount: mediaImages.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        mediaImages[index],
                        width: 100,
                        height: 95,
                        fit: BoxFit.cover,
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
