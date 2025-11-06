import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';

class RewardhistoryScreen extends StatefulWidget {
  const RewardhistoryScreen({Key? key}) : super(key: key);

  @override
  State<RewardhistoryScreen> createState() => _RewardhistoryScreenState();
}

class _RewardhistoryScreenState extends State<RewardhistoryScreen> {


  final List<Map<String, dynamic>> rewardList = [
    {
      "title": "Rose Tea Refill",
      "date": "12 Aug 2025",
      "location": "Bäckerei Herzstück",
      "usedOn": "15 Aug 2025",
      "pointsSpent": "-50",
      "pointsEarned": "+150",
      "image": "assets/rose.png",
    },
    {
      "title": "Chocolate Croissant",
      "date": "10 Aug 2025",
      "location": "Café Blumenkind",
      "usedOn": "11 Aug 2025",
      "pointsSpent": "-30",
      "pointsEarned": "+100",
      "image": "assets/rose.png",
    },
    {
      "title": "Coffee Voucher",
      "date": "05 Aug 2025",
      "location": "Espresso Haus",
      "usedOn": "06 Aug 2025",
      "pointsSpent": "-40",
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
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Image.asset("assets/backArrow.png", height: 26, width: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Reward History',
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

              ListView.builder(
                itemCount: rewardList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  width: 70,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: App_BlackColor,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image.asset("assets/date.png", height: 13, width: 13),
                                        const SizedBox(width: 5),
                                        Text(
                                          item["date"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                        const Spacer(),
                                        Image.asset("assets/pointDisable.png",
                                            height: 16, width: 16),
                                        const SizedBox(width: 5),
                                        Text(
                                          "Points Spent: ${item["pointsSpent"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: App_BlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image.asset("assets/locationGray.png", height: 13, width: 13),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            item["location"],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: App_BlackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        _buildButton("Used on ${item["usedOn"]}", App_UsedView),
                                        const Spacer(),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFD4C07A),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/gift.png", height: 14, width: 14),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${item["pointsEarned"]} Pts",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
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

                      // 🔹 “Locked” Tag Positioned on top-right corner
                      Positioned(
                        top: 10,
                        right: 0,
                        child: Container(
                          height: 26,
                          width: 78,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: App_SignOut, // your defined color for locked ribbon
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: Text(
                            "Used",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: App_WhiteColor, // your text color for lock label
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: App_BlackColor,
        ),
      ),
    );
  }
}
