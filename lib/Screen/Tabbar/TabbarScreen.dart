import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:sleeping_beauty_app/Screen/Tabbar/Home/Home.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/Journey.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Rewards/Rewards.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Events/Events.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    JourneyScreen(),
    RewardsScreen(),
    EventsScreen(),
  ];

  late final List<AnimationController> _iconControllers;

  final List<String> _selectedIconPaths = [
    'assets/home_selected.png',
    'assets/journeySelected.png',
    'assets/rewardsSelected.png',
    'assets/eventsSelected.png',
  ];

  final List<String> _unselectedIconPaths = [
    'assets/home.png',
    'assets/journey.png',
    'assets/rewards.png',
    'assets/events.png',
  ];

  final List<String> _labels = ["Home", "Journey", "Rewards", "Events"];

  @override
  void initState() {
    super.initState();
    _iconControllers = List.generate(
      _pages.length,
          (_) => AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        lowerBound: 0.9,
        upperBound: 1.2,
      )..value = 1.0,
    );
    _iconControllers[_selectedIndex].forward();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ❌ Prevent back button completely
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFEFECEC),
        extendBody: false,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(43),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_labels.length, (index) {
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: SizedBox(
                    width: 60,
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
                        const SizedBox(height: 4),
                        Text(
                          _labels[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            foreground: isSelected
                                ? (Paint()..color = const Color(0xFF2CA28C))
                                : (Paint()
                              ..shader = ui.Gradient.linear(
                                const Offset(0, 0),
                                const Offset(0, 20),
                                [
                                  Color(0xFFD7F4EF),
                                  Color(0xFFFFFFFF),
                                ],
                              )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}