import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sleeping_beauty_app/Core/Color.dart';

class EditprofileScreen extends StatefulWidget {
  @override
  State<EditprofileScreen> createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _emailController.text = "johndoe@gmail.com";
  }

  // 🔹 Function to pick image
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

  // 🔹 Bottom sheet for camera/gallery options
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
                title: const Text("Camera"),
                onTap: () => _pickImage(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text("Gallery"),
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
              // 🔹 Top bar
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
                      'Profile',
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

              // 🔹 Profile Image (clickable)
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
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : const AssetImage('assets/pf.png') as ImageProvider,
                          backgroundColor: Colors.transparent,
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

              // 🔹 Name field
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
                    labelText: "Full Name",
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

              // 🔹 Email field (disabled)
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
                    labelText: "Email ID",
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

              // 🔹 Image & code section
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/scaner.png",
                      height: 280,
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "345678",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w600,
                        color: App_BlackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}