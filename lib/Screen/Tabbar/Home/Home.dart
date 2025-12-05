import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/CustomSideMenu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Model/Profile.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int tabIndex)? onTabChange;
  const HomeScreen({super.key, this.onTabChange});
  // const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var currentCityName = "";

  User? userData;

  void openDrawer() {
    isSideMenuOpen = true;
    widget.onTabChange?.call(0);
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {

    print("initState Home");

    super.initState();
    getUserLocation().then((city) {
      setState(() {
        currentCityName = city ?? 'Unknown';
      });
    });
    getUsersProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F8F8),
      drawer: const CustomSideMenu(),
        onDrawerChanged: (isOpened) {
          if (!isOpened) {
            // Drawer just closed
            print("Returned to main screen after closing drawer");
            getUsersProfile();
            Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                isSideMenuOpen = false;
                widget.onTabChange?.call(0);
                print("Reload Screen");
              });
            });
          }
        },
      drawerScrimColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Profile Icon
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: openDrawer,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green.shade200, width: 3),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            userData?.avatar?.url ?? 'https://example.com/defaultProfile.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to local dummy image if network fails
                              return Image.asset(
                                'assets/dummyProfile.png',
                                fit: BoxFit.cover,
                              );
                            },
                          )
                          ,
                        ),
                      ),
                    ),
                  ),
                  // Location
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/currentLocation.png', height: 20, width: 20),
                      const SizedBox(width: 5),
                      Text(
                        currentCityName,
                        style: TextStyle(
                          color: App_Cool_Slate,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  // Wallet + Notification
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
                              child: Text(
                                '${(userData?.pointEarn ?? 0).toString()} ${lngTranslation("Pts")}',
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
            // Banner
            // Scrollable content only for banner + grid
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final double width = constraints.maxWidth;
                            final double height = width * 0.65;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/bannerImage.png',
                                  width: double.infinity,
                                  height: height,
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                  bottom: 20,
                                  left: 0,
                                  right: 0,
                                  child: Text(
                                    'Erwecke die Magie\nvon Dornröschen',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    // GRID
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.05,
                        physics: const NeverScrollableScrollPhysics(), // stop grid scroll
                        shrinkWrap: true, // allow inside column
                        children: [
                          _buildFeatureCard('assets/hotelViewCard.png', 'Dornröschenschloss', 92),
                          _buildFeatureCard('assets/mapViewCard.png', 'Wähle deinen Weg', 70),
                          _buildFeatureCard('assets/roseViewCard.png', 'Geschichte hören', 82),
                          _buildFeatureCard('assets/calanderViewCard.png', 'Veranstaltungen entdecken', 60),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String iconPath, String title, double size) {
    return Container(
      decoration: BoxDecoration(
        color: App_Card_View,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: size, width: size),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: App_BlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
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
