import 'package:linc_driver/tugas/models/model_walkthrough.dart';
import 'package:linc_driver/tugas/views/view_login.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TugasWalkthrough extends StatefulWidget {
  const TugasWalkthrough({super.key});

  @override
  State<TugasWalkthrough> createState() => _TugasWalkthroughState();
}

class _TugasWalkthroughState extends State<TugasWalkthrough> {
  int positionImage = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        positionImage = pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _skipWalkthrough() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("skipWalkthrough", true);
      Get.off(() => const ViewLogin());
    } catch (e) {
      // Tangani kesalahan jika diperlukan
    }
  }

  void _completeWalkthrough() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("skipWalkthrough", true);
      Get.off(() => const ViewLogin());
    } catch (e) {
      // Tangani kesalahan jika diperlukan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFB71C1C), // Mengubah warna latar belakang menjadi merah tua
      body: SafeArea(
        child: Center(
          child: PageView.builder(
              controller: pageController,
              itemCount: walkthroughList.length,
              itemBuilder: (context, index) {
                ModelWalkthrough data = walkthroughList[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        data.title!,
                        style: const TextStyle(
                          fontFamily:
                              'Montserrat', // Menggunakan font Montserrat
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color:
                              Colors.white, // Mengubah warna teks menjadi putih
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Gunakan Expanded untuk menghindari overflow
                      Expanded(
                        child: Container(
                          color: Colors
                              .red[800], // Latar belakang merah tua di luar GIF
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                                width: 200, // Lebar kontainer
                                height: 200, // Tinggi kontainer
                                data.image!, // Menggunakan GIF animasi
                                fit: BoxFit
                                    .contain // Mengatur ukuran gambar agar sesuai dengan area
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Mengurangi ruang di bawah GIF
                      Text(
                        data.description!,
                        style: const TextStyle(
                          fontFamily:
                              'Montserrat', // Menggunakan font Montserrat
                          fontSize: 16,
                          color: Colors
                              .white70, // Warna teks deskripsi sedikit lebih terang
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _skipWalkthrough,
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontFamily: 'Montserrat', // Menggunakan font Montserrat
                  color: Colors.white,
                ),
              ),
            ),
            DotsIndicator(
              dotsCount: walkthroughList.length,
              position: positionImage,
              decorator: const DotsDecorator(
                activeColor: Colors.white, // Warna titik aktif
                color: Colors.white54, // Warna titik tidak aktif
              ),
            ),
            GestureDetector(
              onTap: () {
                if (positionImage < walkthroughList.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  _completeWalkthrough();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.orange, // Warna tombol bisa disesuaikan
                  child: Center(
                    child: Icon(
                      positionImage == walkthroughList.length - 1
                          ? Icons.check
                          : Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
