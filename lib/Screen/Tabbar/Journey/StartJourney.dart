import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/JourneyListOnMapView.dart';

class StartJourneyScreen extends StatefulWidget {

  final String title;
  final String imagePath;

  const StartJourneyScreen({Key? key, required this.title, required this.imagePath}) : super(key: key);

  @override
  State<StartJourneyScreen> createState() => _StartJourneyScreenState();
}

class _StartJourneyScreenState extends State<StartJourneyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset("assets/backArrow.png", height: 26, width: 26),
                    const SizedBox(width: 10),
                    Text(
                      'Journey',
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

            // Banner Image with Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double width = constraints.maxWidth;
                    final double height = width * 0.50;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/nature.png',
                          width: double.infinity,
                          height: height,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Centered Image
            Center(
              child: Image.asset(
                widget.imagePath,
                width: 92,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Center(
               child:  Text(
                 widget.title,
               style: TextStyle(
               fontSize: 20,
               fontWeight: FontWeight.w600,
               color: App_BlackColor),
        )),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Follow the path where Sleeping Beauty and her prince once walked – through roses, lights, flavours, and stories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: App_BlackColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: App_Start_Now,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: () async {
                    print("Start Now pressed");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const JourneyListOnMapViewScreen(title: 'Wellness Journey', imagePath: 'assets/wellness.png'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start Now",
                        style: TextStyle(
                          color: App_BlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Image.asset(
                        'assets/rightSideArrow.png',
                        width: 26,
                        height: 26,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
