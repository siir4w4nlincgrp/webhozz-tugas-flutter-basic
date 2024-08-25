import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:linc_driver/tugas/utils/urls.dart';
import 'package:linc_driver/tugas/views/view_home.dart';
import 'package:linc_driver/tugas/views/view_login.dart';
import 'package:linc_driver/tugas/views/view_walkthrough.dart';

class TugasSplash extends StatefulWidget {
  const TugasSplash({super.key});

  @override
  State<TugasSplash> createState() => _TugasSplashState();
}

class _TugasSplashState extends State<TugasSplash> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    // No use of inherited widgets here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now it is safe to access inherited widgets like MediaQuery
    cekTokenLogin();
  }

  void cekTokenLogin() async {
    try {
      // Beri sedikit waktu sebelum memeriksa token
      await Future.delayed(const Duration(seconds: 3));

      final preferences = await _prefs;

      String accessToken = preferences.getString("access_token") ?? "";
      String tokenType = preferences.getString("token_type") ?? "";

      if (accessToken.isNotEmpty && tokenType.isNotEmpty) {
        dio.options.headers["Authorization"] = "$tokenType $accessToken";
        var response = await dio.post("${baseURL}api/check");

        if (response.statusCode == 200) {
          Get.off(() => const ViewHome());
        } else {
          _checkSkipWalkthrough();
        }
      } else {
        _checkSkipWalkthrough();
      }
    } catch (e) {
      _checkSkipWalkthrough();
    }
  }

  void _checkSkipWalkthrough() async {
    final prefs = await _prefs;
    bool skipWalkthrough = prefs.getBool("skipWalkthrough") ?? false;

    if (skipWalkthrough) {
      Get.off(() => const ViewLogin());
    } else {
      Get.off(() => const TugasWalkthrough());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // Background Image
              Image.asset(
                "assets/images/red truck.jpeg",
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              // Semi-transparent Overlay
              Container(
                color: Colors.black.withOpacity(
                    0.5), // Darker overlay for better text visibility
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              // Centered Text with modern style
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32.0, // Adjust size as needed
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white, // Text color
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 2),
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "LincDriver",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48.0, // Adjust size as needed
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Color(0xFFB71C1C), // Text color
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 2),
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3.0,
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