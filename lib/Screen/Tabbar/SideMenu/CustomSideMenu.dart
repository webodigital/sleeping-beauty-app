import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/EditProfile.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/MyJourneyHistory.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/MyFavoriteJourney.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/RewardHistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Model/Profile.dart';
import 'package:sleeping_beauty_app/Screen/Auth/LoginScreen.dart';

class CustomSideMenu extends StatefulWidget {
  const CustomSideMenu({super.key});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  String selectedLanguage = "English";

  User? userData;

  @override
  void initState() {
    super.initState();
    _getDefaultLanguage();
     getUsersProfile();
  }

  Future<void> _getDefaultLanguage() async {
    final lng = await loadLng(); // Wait for async value
    setState(() {
      selectedLanguage = (lng.toLowerCase() == "en") ? "English" : "German";
    });
  }

  Future<void> saveLngForUser(String typeLng) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('saveLngForUser', typeLng);
  }

  Future<String> loadLng() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('Language') ?? "en"; // default to English

    if (saved.toLowerCase() == "gr") return "gr";
    return "en";
  }

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

      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: App_PtnView.withOpacity(0.30), width: 4),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      userData?.avatar?.url ?? 'https://example.com/defaultProfile.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/dummyProfile.png',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userData?.fullName ?? "",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: App_BlackColor),
                ),
                Text(
                  userData?.email ?? "",
                  style: TextStyle(
                      color: App_TextProfile,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const SizedBox(height: 20),

                DrawerItem(
                  icon: "assets/profile.png",
                  title: lngTranslation("Profile"),
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
                  title: lngTranslation("My Events"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/myEvents');
                  },
                ),
                DrawerItem(
                  icon: "assets/myJourney.png",
                  title: lngTranslation("My Journey"),
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
                  title: lngTranslation("My Favourites"),
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
                  title: lngTranslation("About App"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/aboutApp');
                  },
                ),
                DrawerItem(
                  icon: "assets/rewardHistory.png",
                  title: lngTranslation("Reward History"),
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
                  title: lngTranslation("Helps & FAQs"),
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

                              setState(() {
                                selectedSavedLanguage = value!;
                                selectedLanguage = value;
                                final code = value == "English" ? "EN" : "GR";
                                TranslationManager().setLanguage(code);
                                saveLngForUser(code);
                                _getDefaultLanguage();
                              });
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
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                  label: Text(
                    lngTranslation("Sign Out"),
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
          title: Center(
            child: Text(
              lngTranslation("Log Out"),
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          content: Text(
            lngTranslation("Are you sure you want to log out?"),
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
                      lngTranslation("Cancel"),
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: App_Start_Now,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      lngTranslation("Yes"),
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

  Future<void> getUsersProfile() async {
    EasyLoading.show(status: lngTranslation('Loading...'));
    try {
      final response = await apiService.getRequest(ApiConstants.users_profile_get);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        print("data:-- $data");

        if (data['success'] == true) {

          EasyLoading.dismiss();
          setState(() {
            final profile = ProfileResponse.fromJson(response.data);
            userData = profile.data?.user;
          });
        } else {
          EasyLoading.dismiss();
          String errorMessage = data['message'] ?? lngTranslation(AlertConstants.somethingWrong);
          EasyLoading.showError(errorMessage);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(lngTranslation(AlertConstants.somethingWrong));
      }
    } catch (e, stackTrace) {
      print("Error fetching getUsersProfile: $e");
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getUsersProfile finished");
    }
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
        padding: const EdgeInsets.symmetric(vertical: 17),
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
