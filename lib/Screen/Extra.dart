// import 'package:flutter/material.dart';
// import 'package:sleeping_beauty_app/Core/Color.dart';
//
// class RewardhistoryScreen extends StatefulWidget {
//   const RewardhistoryScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RewardhistoryScreen> createState() => _RewardhistoryScreenState();
// }
//
// class _RewardhistoryScreenState extends State<RewardhistoryScreen> {
//   final Color App_BlackColor = const Color(0xFF1C1C1C);
//   final Color App_Card_View = Colors.white;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8F8),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(bottom: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 🔹 Header
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Row(
//                     children: [
//                       Image.asset("assets/backArrow.png", height: 26, width: 26),
//                       const SizedBox(width: 10),
//                       Text(
//                         'Reward History',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: App_BlackColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               // 🔹 Reward Card
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Container(
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   decoration: BoxDecoration(
//                     color: App_Card_View,
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12.withOpacity(0.08),
//                         blurRadius: 6,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             "assets/rose.png",
//                             width: 70,
//                             height: 90,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//
//                         const SizedBox(width: 12),
//
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Text(
//                                       "Rose Tea Refill",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                         color: App_BlackColor,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(height: 6),
//                               Row(
//                                 children: [
//                                   Image.asset("assets/date.png", height: 13, width: 13),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     "12 Aug 2025",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: App_BlackColor,
//                                     ),
//                                   ),
//                                   const Spacer(),
//                                   Image.asset("assets/pointDisable.png", height: 16, width: 16),
//                                   const SizedBox(width: 5),
//                                   Text(
//                                     "Points Spent: -50",
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w500,
//                                       color: App_BlackColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 6),
//                               Row(
//                                 children: [
//                                   Image.asset("assets/locationGray.png", height: 13, width: 13),
//                                   const SizedBox(width: 5),
//                                   Expanded(
//                                     child: Text(
//                                       "Bäckerei Herzstück",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500,
//                                         color: App_BlackColor,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   _buildButton("Used on 15 Aug 2025", App_UsedView),
//                                   const Spacer(),
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFD4C07A),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                     child: Row(
//                                       children: [
//                                         Image.asset("assets/gift.png", height: 14, width: 14),
//                                         const SizedBox(width: 4),
//                                         const Text(
//                                           "+150 Pts",
//                                           style: TextStyle(
//                                             fontSize: 11,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildButton(String text, Color color) {
//     return Container(
//       height: 24,
//       alignment: Alignment.center,
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           fontSize: 11,
//           fontWeight: FontWeight.w500,
//           color: App_BlackColor,
//         ),
//       ),
//     );
//   }
// }
