import 'package:linc_driver/tugas/views/view_login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// Constants for styling
const Color kPrimaryColor = Color(0xFFB71C1C); // Dark Red
const Color kBackgroundColor = Color(0xFFF5F5F5); // Light Grey
const double kBorderRadius = 12.0;
const double kPadding = 20.0;
const double kFontSize = 16.0;

class FragProfile extends StatelessWidget {
  const FragProfile({super.key});

  Future<Map<String, String>> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name') ?? 'No Name',
      'email': prefs.getString('email') ?? 'No Email',
    };
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final skipWalkthrough = prefs.getBool("skipWalkthrough") ?? false;

    // Hapus semua data kecuali 'skipWalkthrough'
    await prefs.clear();
    await prefs.setBool("skipWalkthrough", skipWalkthrough);

    Get.offAll(() => const ViewLogin()); // Kembali ke halaman login dan menghapus semua halaman sebelumnya dari stack
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: FutureBuilder<Map<String, String>>(
          future: _loadProfileData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final profileData = snapshot.data!;
              return _buildProfileContent(context, profileData);
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, Map<String, String> profileData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Info Header
        Column(
          children: [
            const Text(
              'Profile Info',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: kFontSize + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: kPadding / 2),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.person,
                color: kPrimaryColor,
                size: 50,
              ),
            ),
          ],
        ),
        const SizedBox(height: kPadding),
        // Profile Details Card
        Container(
          padding: const EdgeInsets.all(kPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kBorderRadius),
            border: Border.all(color: Colors.transparent),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildReadOnlyInput('Name', profileData['name']!),
              const SizedBox(height: kPadding / 2), // Reduced space between fields
              _buildReadOnlyInput('Email', profileData['email']!),
            ],
          ),
        ),
        const SizedBox(height: kPadding),
        // Logout Button
        IconButton(
          onPressed: () => _logout(context),
          icon: const Icon(
            Icons.logout,
            color: kPrimaryColor,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyInput(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: kPadding / 2),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: kPrimaryColor,
            fontSize: kFontSize,
            fontWeight: FontWeight.w600,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        enabled: false,
      ),
    );
  }
}
