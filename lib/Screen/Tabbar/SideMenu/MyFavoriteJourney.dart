import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:flutter/material.dart';

class MyFavoriteJourneyScreen extends StatefulWidget {
  const MyFavoriteJourneyScreen({Key? key}) : super(key: key);

  @override
  State<MyFavoriteJourneyScreen> createState() => _MyFavoriteJourneyState();
}

class _MyFavoriteJourneyState extends State<MyFavoriteJourneyScreen> {
  final Color App_BlackColor = const Color(0xFF1C1C1C);
  final Color App_Card_View = Colors.white;
  final Color App_Devider = const Color(0xFFBDBDBD);

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
                        lngTranslation('My Favorite Journeys'),
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

              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F8FE),
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(
                      color: const Color(0x7DD2D2D2), // #D2D2D27D
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 13,
                      color: App_BlackColor,
                    ),
                    decoration: InputDecoration(
                      hintText:
                      lngTranslation("Search by Romantic, Adventure, Family, Cultural etc"),
                      hintStyle: TextStyle(
                        color: App_SearchText,
                        fontSize: 13,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 12,right: 2,top: 12,bottom: 12),
                        child: Image.asset(
                          "assets/search.png",
                          height: 18,
                          width: 18,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

        ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
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
                    padding: const EdgeInsets.fromLTRB(12, 14, 10, 0),

                    // 👇 Add IntrinsicHeight here
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ❤️ Left Icon
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 22),
                              Image.asset(
                                "assets/romanticJourney.png",
                                height: 42,
                                width: 42,
                                color: Colors.grey.shade400,
                              ),
                            ],
                          ),
                          const SizedBox(width: 9),
                          // 👇 Divider will now match column height
                          Container(
                            width: 1,
                            margin: const EdgeInsets.only(top: 0, bottom: 50),
                            color: App_Devider.withAlpha(90),
                          ),

                          const SizedBox(width: 12),

                          // 🔹 Journey Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Romantic Journey",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: App_BlackColor,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Image.asset("assets/date.png", height: 16, width: 16),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "14–17 Aug 2025",
                                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(width: 32),
                                    Image.asset("assets/locationGray.png", height: 22, width: 22),
                                    const SizedBox(width: 10),
                                    const Text(
                                      "6 Stop",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Image.asset("assets/locationGray.png", height: 16, width: 16),
                                    const SizedBox(width: 10),
                                    const Expanded(
                                      child: Text(
                                        "Hofgeismar",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: _buildButton("View Details", App_SignOut),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: _buildButton("Start Journey", App_SignOut),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD4C07A),
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset("assets/gift.png", height: 14, width: 14),
                                            const SizedBox(width: 4),
                                            const Text(
                                              "+150 Pts",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
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

                // ❤️ Heart Top Right
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => print("Heart clicked!"),
                    child: Image.asset(
                      "assets/selectedHeart.png",
                      height: 26,
                      width: 26,
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

  // Helper Widget
  Widget _buildButton(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: App_BlackColor,
        ),
      ),
    );
  }
}
