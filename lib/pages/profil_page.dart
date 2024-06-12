import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/database_profile.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/pages/edit_profile.dart';
import 'package:uas_2103040136_pemrograman_mobile_lanjut/utils/profile_model.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile? _profile;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _loadImagePath();
  }

  Future<void> _loadProfile() async {
    final profile = await DatabaseProfile().getProfile();
    setState(() {
      _profile = profile;
    });
  }

  Future<void> _loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagePath = prefs.getString('profile_image_path');
    });
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', pickedFile.path);
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _removeImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_image_path');
    setState(() {
      _imagePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red,
                              width: 3.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            backgroundImage: _imagePath != null
                                ? FileImage(File(_imagePath!))
                                : AssetImage('assets/images/profile.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _removeImage,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    _profile?.name ?? 'Agam Pratama',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                  Text(
                    _profile?.email ?? 'coba123@gmail.com',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _profile?.country ?? 'Indonesia',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      );
                      if (result == true) {
                        _loadProfile(); // Reload profile after editing
                      }
                    },
                    child: Text('Edit Your Profile',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.shopping_cart, color: Colors.black),
                    title: Text('Shopping Cart',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    trailing: Text('5',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18)), // Replace 5 with the actual number
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.black),
                    title: Text('Favourite Product',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    trailing: Text('10',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18)), // Replace 10 with the actual number
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
