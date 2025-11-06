import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/EditProfile.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/MyJourneyHistory.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/MyFavoriteJourney.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/RewardHistory.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      backgroundColor: App_WhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      //Removed SafeArea
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40), // Added spacing to avoid overlap with close icon
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: App_PtnView.withOpacity(0.30), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 38,
                    backgroundImage: AssetImage('assets/profile.png'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "John Doe",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: App_BlackColor),
                ),
                Text(
                  "Johndoe@gmail.com",
                  style: TextStyle(
                      color: App_TextProfile,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const SizedBox(height: 25),

                DrawerItem(
                  icon: "assets/profile.png",
                  title: "Profile",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditprofileScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: "assets/myEvent.png",
                  title: "My Events",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/myEvents');
                  },
                ),
                DrawerItem(
                  icon: "assets/myJourney.png",
                  title: "My Journey",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyjourneyhistoryScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: "assets/myFavourites.png",
                  title: "My Favourites",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyFavoriteJourneyScreen()),
                    );
                  },

                ),
                DrawerItem(
                  icon: "assets/aboutApp.png",
                  title: "About App",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/aboutApp');
                  },
                ),
                DrawerItem(
                  icon: "assets/rewardHistory.png",
                  title: "Reward History",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RewardhistoryScreen()),
                    );
                  },
                ),
                DrawerItem(
                  icon: "assets/helps.png",
                  title: "Helps & FAQs",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/helps');
                  },
                ),

                const Spacer(),

                Center(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: App_LangBiew,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("assets/changeLanguage.png",
                            width: 24, height: 24),
                        const SizedBox(width: 16),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedLanguage,
                            dropdownColor: App_WhiteColor,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.black),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: App_BlackColor),
                            items: const [
                              DropdownMenuItem(
                                  value: "English", child: Text("English")),
                              DropdownMenuItem(
                                  value: "German", child: Text("German")),
                            ],
                            onChanged: (value) {
                              setState(() => selectedLanguage = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: App_SignOut,
                    foregroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: Text(
                    "Sign Out",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: App_BlackColor),
                  ),
                  onPressed: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),

          // Close Button at Top-Right Corner
          Positioned(
            top: 40,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Center(
            child: Text(
              "Log Out",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          actionsPadding: const EdgeInsets.only(right: 12, bottom: 8, left: 12),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: App_Start_Now, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: App_BlackColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      // TODO: Add logout logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: App_Start_Now,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: App_BlackColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onTap;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
