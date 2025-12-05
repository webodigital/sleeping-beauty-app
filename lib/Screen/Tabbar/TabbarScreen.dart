import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Home/Home.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/Journey.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Rewards/Rewards.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Events/Events.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:device_info_plus/device_info_plus.dart';

var isData = 0;

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late final List<AnimationController> _iconControllers;
  late final List<Widget> _pages;

  final List<String> _labels = ["Home", "Journey", "Rewards", "Events"];

  final List<String> _selectedIconPaths = [
    'assets/home_selected.png',
    'assets/journeySelected.png',
    'assets/rewardsSelected.png',
    'assets/eventsSelected.png',
  ];

  final List<String> _unselectedIconPaths = [
    'assets/home_.png',
    'assets/journey_.png',
    'assets/rewords_.png',
    'assets/events_.png'
  ];

  bool isIPad = false;

  @override
  void initState() {
    super.initState();

    print(" super.initState");
    _pages = [
      HomeScreen(
        onTabChange: (index) {
          setState(() {
            print("Home init");
          });
        },
      ),
      JourneyScreen(
        onTabChange: (index) {
          setState(() {
            print("JourneyScreen init");
          });
        },
      ),
      RewardsScreen(
        onTabChange: (index) {
          setState(() {
            print("RewardsScreen init");
          });
        },
      ),
      EventsScreen(),
    ];

    _iconControllers = List.generate(
      _pages.length,
          (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0.9,
        upperBound: 1.2,
      )..value = 1.0,
    );

    _iconControllers[_selectedIndex].forward();

    print("isIPad:- $isIPad");
    setState(() {
      print("Reload");
    });
    _checkDevice();
  }

  @override
  void dispose() {
    for (var controller in _iconControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _iconControllers[_selectedIndex].reverse();
      _selectedIndex = index;
      _iconControllers[_selectedIndex].forward();
    });
  }

  Future<void> _checkDevice() async {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;

    if (iosInfo.name?.toLowerCase().contains("ipad") ?? false) {
      setState(() {
        isIPad = true;
        print(" isIPad = true; NOW TRUE");
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: App_WhiteColor,
        extendBody: false,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SafeArea(
            top: false,
            child: Container(
              margin:  EdgeInsets.only(bottom: isIPad ? 20 : 5),
              height: isSideMenuOpen ? 0 : 70,
              decoration: BoxDecoration(
                color: App_ThemeColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_labels.length, (index) {
                  final isSelected = index == _selectedIndex;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Container(
                        height: double.infinity, // Full vertical hit area
                        color: Colors.transparent, // Needed to register taps
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ScaleTransition(
                              scale: _iconControllers[index],
                              child: Image.asset(
                                isSelected
                                    ? _selectedIconPaths[index]
                                    : _unselectedIconPaths[index],
                                width: 26,
                                height: 26,
                              ),
                            ),
                            //),
                            const SizedBox(height: 4),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                lngTranslation(_labels[index]),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  foreground: isSelected
                                      ? (Paint()..color = App_Text_BlackColor)
                                      : (Paint()
                                    ..shader = ui.Gradient.linear(
                                      const Offset(0, 0),
                                      const Offset(0, 20),
                                      [
                                        App_Text_BlackColor,
                                        App_Text_BlackColor,
                                      ],
                                    )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
