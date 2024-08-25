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
      body: FutureBuilder<Map<String, String>>(
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
    );
  }

  Widget _buildProfileContent(BuildContext context, Map<String, String> profileData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Divider with text "Profile Info"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: const Text(
                  'Profile Info',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: kFontSize + 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: kPrimaryColor,
                thickness: 2,
              ),
            ],
          ),
        ),
        // Profile Details Box Shadow
        Container(
          margin: const EdgeInsets.all(kPadding),
          padding: const EdgeInsets.all(kPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(kBorderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5), // Larger shadow below
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildReadOnlyInput('Name', profileData['name']!),
              const SizedBox(height: kPadding / 2), // Reduced space between shadows
              _buildReadOnlyInput('Email', profileData['email']!),
              const SizedBox(height: kPadding),
              ElevatedButton(
                onPressed: () => _logout(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                  ),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlyInput(String label, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: kPrimaryColor,
          fontSize: kFontSize,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: kBackgroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      enabled: false,
    );
  }
}
