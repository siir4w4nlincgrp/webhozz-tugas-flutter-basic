import 'package:linc_driver/tugas/fragments/frag_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linc_driver/tugas/fragments/frag_home.dart';

class ViewHome extends StatefulWidget {
  const ViewHome({super.key});

  @override
  State<ViewHome> createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    const FragHome(),
    const FragProfile()
  ];

  Future<String?> _getNameFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: _getNameFromPreferences(),
          builder: (context, snapshot) {
            final name = snapshot.data ?? 'User';
            return Text('Hi $name', style: const TextStyle(fontSize: 16, color: Colors.white));
          },
        ),
        backgroundColor: const Color(0xFFB71C1C), // Menjaga warna merah
        elevation: 4,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: _pages[currentIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => _onItemTapped(0),
              icon: Icon(Icons.home, color: currentIndex == 0 ? const Color(0xFFB71C1C) : Colors.black),
            ),
            IconButton(
              onPressed: () => _onItemTapped(1),
              icon: Icon(Icons.person, color: currentIndex == 1 ? const Color(0xFFB71C1C) : Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the Floating Action Button
        },
        backgroundColor: const Color(0xFFB71C1C), // Menjaga warna merah
        child: const Icon(
          Icons.camera_alt_outlined, // Tidak merubah ikon
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
