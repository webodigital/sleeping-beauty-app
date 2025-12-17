import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';
import 'package:sleeping_beauty_app/Helper/Language.dart';
import 'package:sleeping_beauty_app/Network/ApiConstants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sleeping_beauty_app/Network/ConstantString.dart';
import 'package:sleeping_beauty_app/Model/Profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class EditprofileScreen extends StatefulWidget {
  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {

  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  File? _selectedImage;

  User? userData;

  @override
  void initState() {
    super.initState();

    getUsersProfile();
  }

  // Function to pick image
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
    Navigator.pop(context);
  }

  // Bottom sheet for camera/gallery options
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: Text(lngTranslation("Camera")),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: Text(lngTranslation("Gallery")),
                onTap: () => _pickImage(ImageSource.gallery),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset("assets/backArrow.png", height: 26, width: 26),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      lngTranslation('Profile'),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: App_BlackColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Profile Image (clickable)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: GestureDetector(
                  onTap: _showImagePickerOptions,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: App_ProfileBorder,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 38, // optional, adjust size
                          backgroundColor: Colors.transparent,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!) as ImageProvider
                              : (userData?.avatar?.url != null && userData!.avatar!.url!.isNotEmpty)
                              ? NetworkImage(userData!.avatar!.url!)
                              : const AssetImage('assets/pf.png'),
                          onBackgroundImageError: (_, __) {
                            // optional: handle image load error gracefully
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/editCamera.png", height: 20, width: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Name field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: _NameController,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: App_BlackColor,
                  ),
                  decoration: InputDecoration(
                    labelText: lngTranslation("Full Name"),
                    labelStyle: TextStyle(
                      color: App_DarkGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: App_DarkGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8F8),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFD5D5D5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFD5D5D5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFF60778C), width: 1.4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              //Email field (disabled)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                  controller: _emailController,
                  readOnly: true,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: App_BlackColor,
                  ),
                  decoration: InputDecoration(
                    labelText: lngTranslation("Email ID"),
                    labelStyle: TextStyle(
                      color: App_DarkGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: App_DarkGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF8F8F8),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFD5D5D5)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFFD5D5D5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Color(0xFF60778C), width: 1.4),
                    ),
                  ),
                ),
              ),

              // Image & code section
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: App_Warm_Gray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () async {
                      print("Upload pressed");
                      _uploadImage();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const TabBarScreen(),
                      //   ),
                      // );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          lngTranslation("Update"),
                          style: TextStyle(
                            color: App_BlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userData?.qrUrl != null && userData!.qrUrl!.isNotEmpty)
                      QrImageView(
                        data: userData!.qrUrl!,
                        version: QrVersions.auto,
                        size: 200.0,
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Colors.black,
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.circle,
                          color: Colors.black,
                        ),
                      ),
                    const SizedBox(height: 12),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _uploadImage() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

    EasyLoading.show(status: lngTranslation('Uploading...'));

    print("isFileSelected:-- $_selectedImage");
    print("------------------------");

    String fileURL = "";

    if (_selectedImage != null && _selectedImage!.path.isNotEmpty) {
      fileURL = _selectedImage!.path;
    }

    else if (userData?.avatar?.url?.isNotEmpty == true) {
      fileURL = userData?.avatar?.url ?? "";
    }

    if (fileURL.isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showError(lngTranslation(AlertConstants.profilePhoto));
      return;
    }

    if (_NameController.text.trim().isEmpty) {
      EasyLoading.dismiss();
      EasyLoading.showError(lngTranslation(AlertConstants.userNameBlank));
      return;
    }

    try {
      final response = await apiService.uploadPhoto(
        endpoint: ApiConstants.users_profile_update,
        profileImage: fileURL,
        fullName: _NameController.text.trim(),
      );

      final data = response.data;

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data['success'] == true) {
        EasyLoading.showSuccess(data['message']);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
      } else {
        EasyLoading.showError(lngTranslation(AlertConstants.profileUploadfailed));
      }
    } catch (e) {
      EasyLoading.showError(lngTranslation(AlertConstants.somethingWrong));
      print("Upload error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> getUsersProfile() async {

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (!isConnected) {
      EasyLoading.showError(ApiConstants.noInterNet);
      return;
    }

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
            _emailController.text = userData?.email ?? "";
            _NameController.text = userData?.fullName ?? "";
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