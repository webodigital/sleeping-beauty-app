import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/StartJourney.dart';

class JourneyScreen extends StatefulWidget {
  const JourneyScreen({Key? key}) : super(key: key);

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  //Profile
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green.shade200, width: 3),
                      ),
                      child: ClipOval(
                        child: Image.asset('assets/dummyProfile.png', fit: BoxFit.cover),
                      ),
                    ),
                  ),

                  //Location
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/currentLocation.png', height: 20, width: 20),
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
                  //Wallet
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
                              child: Image.asset('assets/wallet.png', height: 20),
                            ),
                            Positioned(
                              bottom: -14,
                              child: const Text(
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
                              Image.asset('assets/notification.png', height: 28),
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
            //Banner Image with Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double width = constraints.maxWidth;
                    final double height = width * 0.50; // dynamic height based on width

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        //Background image
                        Image.asset(
                          'assets/bannerImage.png',
                          width: double.infinity,
                          height: height,
                          fit: BoxFit.cover,
                        ),

                        //Text overlay
                        Positioned(
                          bottom: 20, // space at the bottom of the text
                          left: 0,
                          right: 0,
                          child: const Text(
                            'Erwecke die Magie\nvon Dornröschen',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.3, // line spacing
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 0),
              child: Text(
                'Choose Your Path',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: App_BlackColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 🔹 Journey List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children: [
                  _buildJourneyCard(
                    'assets/wellness.png', 'Wellness Journey',
                    onTap: () {
                      print('Wellness Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Wellness Journey', imagePath: 'assets/wellness.png'),
                        ),
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => WellnessScreen()));
                    },
                  ),
                  _buildJourneyCard(
                    'assets/familyJourney.png', 'Family Journey',
                    onTap: () {
                      print('Family Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Family Journey', imagePath: 'assets/familyJourney.png'),
                        ),
                      );
                    },
                  ),
                  _buildJourneyCard(
                    'assets/romanticJourney.png', 'Romantic Journey',
                    onTap: () {
                      print('Romantic Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Romantic Journey', imagePath: 'assets/romanticJourney.png'),
                        ),
                      );
                    },
                  ),
                  _buildJourneyCard(
                    'assets/culturalJourney.png', 'Cultural Journey',
                    onTap: () {
                      print('Cultural Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Cultural Journey', imagePath: 'assets/culturalJourney.png'),
                        ),
                      );
                    },
                  ),
                  _buildJourneyCard(
                    'assets/inclusionJourney.png', 'Inclusion Journey',
                    onTap: () {
                      print('Inclusion Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Inclusion Journey', imagePath: 'assets/inclusionJourney.png'),
                        ),
                      );
                    },
                  ),
                  _buildJourneyCard(
                    'assets/camperVanJourney.png', 'Camper Van Journey',
                    onTap: () {
                      print('Camper Van Journey tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StartJourneyScreen(title: 'Camper Van Journey', imagePath: 'assets/camperVanJourney.png'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyCard(String iconPath, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // ensures ripple matches shape
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 36, width: 36),
            Container(
              width: 1,
              height: 42,
              color: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: App_BlackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
