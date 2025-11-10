import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Home/Home.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/Journey.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Rewards/Rewards.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Events/Events.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
//
// class TabBarScreen extends StatefulWidget {
//   const TabBarScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TabBarScreen> createState() => _TabBarScreenState();
// }
//
// class _TabBarScreenState extends State<TabBarScreen>
//     with TickerProviderStateMixin {
//   int _selectedIndex = 0;
//
//   late final List<AnimationController> _iconControllers;
//
//   final List<Widget> _pages = const [
//     HomeScreen(),
//     JourneyScreen(),
//     RewardsScreen(),
//     EventsScreen(),
//   ];
//
//   final List<String> _labels = ["Home", "Journey", "Rewards", "Events"];
//   // final List<String> _labels = ["Home", "Journey", "Rewards"];
//
//   final List<String> _selectedIconPaths = [
//     'assets/home_selected.png',
//     'assets/journeySelected.png',
//     'assets/rewardsSelected.png',
//     'assets/eventsSelected.png',
//   ];
//
//   // final List<String> _selectedIconPaths = [
//   //   'assets/home_selected.png',
//   //   'assets/journeySelected.png',
//   //   'assets/rewardsSelected.png'
//   // ];
//
//   final List<String> _unselectedIconPaths = [
//     'assets/home_.png',
//     'assets/journey_.png',
//     'assets/rewords_.png',
//     'assets/events_.png'
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _iconControllers = List.generate(
//       _pages.length,
//           (_) => AnimationController(
//         vsync: this,
//         duration: const Duration(milliseconds: 300),
//         lowerBound: 0.9,
//         upperBound: 1.2,
//       )..value = 1.0,
//     );
//
//     _iconControllers[_selectedIndex].forward();
//   }
//
//   @override
//   void dispose() {
//     for (var controller in _iconControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onItemTapped(int index) {
//     if (index == _selectedIndex) return;
//
//     setState(() {
//       _iconControllers[_selectedIndex].reverse();
//       _selectedIndex = index;
//       _iconControllers[_selectedIndex].forward();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Scaffold(
//         backgroundColor: App_WhiteColor,
//         extendBody: false,
//         body: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           child: _pages[_selectedIndex],
//         ),
//         bottomNavigationBar: Padding(
//           padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
//           child: Container(
//             height: 70,
//             decoration: BoxDecoration(
//               color: App_ThemeColor,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.15),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: List.generate(_labels.length, (index) {
//                 final isSelected = index == _selectedIndex;
//
//                 return GestureDetector(
//                   onTap: () => _onItemTapped(index),
//                   child: SizedBox(
//                     width: 64,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ScaleTransition(
//                           scale: _iconControllers[index],
//                           child: Image.asset(
//                             isSelected
//                                 ? _selectedIconPaths[index]
//                                 : _unselectedIconPaths[index],
//                             width: 26,
//                             height: 26,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           lngTranslation(_labels[index]),
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 13,
//                             foreground: isSelected
//                                 ? (Paint()..color = App_Text_BlackColor)
//                                 : (Paint()
//                               ..shader = ui.Gradient.linear(
//                                 const Offset(0, 0),
//                                 const Offset(0, 20),
//                                 [
//                                   App_Text_BlackColor,
//                                   App_Text_BlackColor,
//                                 ],
//                               )),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late final List<AnimationController> _iconControllers;

  final List<Widget> _pages = const [
    HomeScreen(),
    JourneyScreen(),
    RewardsScreen(),
    EventsScreen(),
  ];

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

  @override
  void initState() {
    super.initState();

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
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: App_WhiteColor,
        extendBody: false,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _pages[_selectedIndex],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
          child: Container(
            height: 70,
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_labels.length, (index) {
                final isSelected = index == _selectedIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onItemTapped(index),
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
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
