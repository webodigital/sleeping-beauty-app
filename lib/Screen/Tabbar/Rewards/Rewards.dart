import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final List<Map<String, dynamic>> offers = [
    {
      "image": "assets/shop.png",
      "title": "Spa Serenity",
      "description": "Get 20% off your next spa booking",
      "unlocked": true,
    },
    {
      "image": "assets/shop.png",
      "title": "Coffee Time",
      "description": "Enjoy a free drink at select cafés",
      "unlocked": false,
    },
    {
      "image": "assets/shop.png",
      "title": "Luxury Stay",
      "description": "Save 15% on your first staycation booking",
      "unlocked": true,
    },
    {
      "image": "assets/shop.png",
      "title": "Adventure Bonus",
      "description": "Earn double points for your next adventure booking",
      "unlocked": false,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                        Border.all(color: Colors.green.shade200, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/dummyProfile.png',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/currentLocation.png',
                          height: 20, width: 20),
                      const SizedBox(width: 5),
                      Text(
                        'Hofgeismar',
                        style: TextStyle(
                          color: App_Cool_Slate,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.shade100,
                              ),
                              child: Image.asset('assets/wallet.png',
                                  height: 20),
                            ),
                            const Positioned(
                              bottom: -14,
                              child: Text(
                                '100 Pts',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5F5F5),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset('assets/notification.png',
                                  height: 28),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// Points Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: App_WhiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/coin.png', height: 60, width: 60),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "You have 125 points",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: App_BlackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle,
                                  size: 14, color: Colors.green),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  "Keep exploring to unlock new experiences",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: App_CointText,
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
            const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              itemCount: offers.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final offer = offers[index];
                final bool isUnlocked = offer["unlocked"] ?? true;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Stack(
                    children: [
                      /// Card Container
                      Container(
                        decoration: BoxDecoration(
                          color: App_WhiteColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                offer["image"] ?? 'assets/sweet.png',
                                height: 70,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer["title"] ?? "Candle Creator",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: App_BlackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 14,
                                        color: isUnlocked ? Colors.green : Colors.grey,
                                      ),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          offer["subtitle"] ??
                                              "Earned by attending the Candle-Making Workshop",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: App_CointText,
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
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 104,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? App_UnLockView
                                : const Color.fromRGBO(212, 212, 213, 1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(6),
                              bottomLeft: Radius.circular(22),
                              bottomRight: Radius.circular(6),
                            ),
                          ),
                          child: Text(
                            isUnlocked ? "Unlocked" : "Locked",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: isUnlocked ? App_WhiteColor : App_TextLockView,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      )
      ],
        ),
      ),
    );
  }
}
