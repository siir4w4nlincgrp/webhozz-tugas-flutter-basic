import 'package:linc_driver/tugas/models/model_main_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FragHome extends StatefulWidget {
  const FragHome({super.key});

  @override
  State<FragHome> createState() => _FragHomeState();
}

class _FragHomeState extends State<FragHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0), // Adjusted bottom padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Main Menu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                  color: Color(0xFFB71C1C), // Keeping the same red color for consistency
                ),
              ],
            ),
          ),
          // Horizontal List View
          SizedBox(
            height: 120, // Increased height for better visibility
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: tugasMainMenu().length,
              itemBuilder: (ctx, index) {
                ModelMainMenu data = tugasMainMenu()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0), // Increased space between items
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(data.routeName!);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80, // Increased width for better visibility
                          height: 80, // Increased height for better visibility
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Changes the shadow direction
                              ),
                            ],
                          ),
                          child: Icon(
                            data.icon,
                            color: data.color,
                            size: 40, // Increased size for better visibility
                          ),
                        ),
                        const SizedBox(height: 12), // Increased space between icon and text
                        Text(
                          data.tittle!,
                          style: const TextStyle(
                            fontSize: 16, // Adjusted font size for better readability
                            fontWeight: FontWeight.w500, // Added weight for emphasis
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
