import 'package:flutter/material.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/StartJourney.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Model/JourneyList.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/SideMenu/CustomSideMenu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sleeping_beauty_app/Model/OnGoingJourny.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/VisitJournyMapview.dart';
import 'package:sleeping_beauty_app/Screen/Tabbar/Journey/JourneyListOnMapView.dart';
import 'package:sleeping_beauty_app/Model/Profile.dart';

class JourneyScreen extends StatefulWidget {
  final void Function(int tabIndex)? onTabChange;
  const JourneyScreen({super.key, this.onTabChange});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}

class _JourneyScreenState extends State<JourneyScreen> {

  JourneyResponse? ongoingJourneyResponse;
  JourneyData? ongoingJourneyData;

  List<Journey> journeyList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var currentCityName = "";
  User? userData;

  void openDrawer() {
    isSideMenuOpen = true;
    widget.onTabChange?.call(1);
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    getUsersProfile();
    getUserLocation().then((city) {
      setState(() {
        currentCityName = city ?? 'Unknown';
      });
      print('Current city: $currentCityName');
    });

    getJourneyList();
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

          Future.delayed(const Duration(milliseconds: 200), () {
            setState(() {
              isSideMenuOpen = false;
              widget.onTabChange?.call(1);
              print("Reload Screen");
            });
          });
        }
      },
      drawerScrimColor: Colors.black.withOpacity(0.5),
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
                          ),
                        ),
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
                        currentCityName,
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
            //Banner Image with Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double width = constraints.maxWidth;
                    final double height = width * 0.50;
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
                lngTranslation('Choose Your Path'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: App_BlackColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: journeyList.length,
                itemBuilder: (context, index) {
                  final journey = journeyList[index];

                  String imagePath = journey.iconUrl ?? 'assets/romanticJourney.png';

                  return _buildJourneyCard(
                    imagePath,
                    journey.name,
                    onTap: () {
                      print('${journey.name} tapped');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StartJourneyScreen(
                            journey: journey,
                            isFromJourneyScreen: false,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
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
            // Image.asset(iconPath, height: 36, width: 36),
        buildImage(iconPath),
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

  Future<void> getJourneyList() async {
    EasyLoading.show(status: lngTranslation('Loading...'));
    try {
      final response = await apiService.getRequest(ApiConstants.journeys);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {
          final journeysResponse = JourneysResponse.fromJson(data);
          EasyLoading.dismiss();
          setState(() {
            journeyList = journeysResponse.data;
          });
          print("Journeys retrieved: ${journeyList.length}");
        } else {
          EasyLoading.dismiss();
          String errorMessage = data['message'] ?? lngTranslation('Something went wrong please try again');
          EasyLoading.showError(errorMessage);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Server Error: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print("Error fetching journeys: $e");
      print(stackTrace);
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getJourneyList finished");
      getOngoingJourneyList();
    }
  }

  Future<void> getOngoingJourneyList() async {
    EasyLoading.show(status: lngTranslation('Loading...'));

    try {
      final response = await apiService.getRequest(ApiConstants.user_journeys_ongoing);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        if (data['success'] == true) {

          ongoingJourneyResponse = JourneyResponse.fromJson(data);
          ongoingJourneyData = ongoingJourneyResponse?.data;

          // Print for debug
          print("Journey fetched successfully");

          EasyLoading.dismiss();


          if (ongoingJourneyData?.businesses.isNotEmpty == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JourneyVisitRootOnMapScreen(
                  isFromJourneyScreen: true,
                  journeyData: ongoingJourneyData!,
                  businessData: null,
                  journyName: ongoingJourneyData?.journeyName ?? "",
                ),
              ),
            ).then((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => JourneyListOnMapViewScreen(
                    journey: null,
                    isFromJourneyScreen: true,
                    journeyID: ongoingJourneyResponse?.data?.journeyId ?? "",
                      journeyName: ongoingJourneyData?.journeyName ?? ""
                  ),
                ),
              );
            });
          } else if ((ongoingJourneyResponse?.data?.journeyId ?? "").isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => JourneyListOnMapViewScreen(
                  journey: null,
                  isFromJourneyScreen: true,
                  journeyID: ongoingJourneyResponse?.data?.journeyId ?? "",
                  journeyName: ongoingJourneyData?.journeyName ?? "",
                ),
              ),
            );
          }

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (_) =>  JourneyVisitRootOnMapScreen(isFromJourneyScreen: true, journeyData: ongoingJourneyData!),
          //   ),
          // );
        } else {
          EasyLoading.dismiss();
          String errorMessage =
              data['message'] ?? lngTranslation('Something went wrong please try again');
          EasyLoading.showError(errorMessage);
        }

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(lngTranslation('Something went wrong please try again'));
      }

    } catch (e, stackTrace) {
      print("Error fetching journeys: $e");
      print(stackTrace);
      EasyLoading.dismiss();
      EasyLoading.showError(AlertConstants.somethingWrong);
    } finally {
      print("getOngoingJourneyList finished");
    }
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

Widget buildImage(String path) {
  bool isNetwork = path.startsWith('http');

  return isNetwork
      ? Image.network(
    path,
    height: 36,
    width: 36,
    fit: BoxFit.cover,
  )
      : Image.asset(
    path,
    height: 36,
    width: 36,
    fit: BoxFit.cover,
  );
}

