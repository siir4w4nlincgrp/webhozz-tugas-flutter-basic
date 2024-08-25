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
      padding: const EdgeInsets.all(16.0),
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
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow),
                ),
              ],
            ),
          ),
          // Horizontal List View
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: tugasMainMenu().length,
              itemBuilder: (ctx, index) {
                ModelMainMenu data = tugasMainMenu()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0), // Space between items
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(data.routeName!);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            data.icon,
                            color: data.color,
                            size: 34,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          data.tittle!,
                          style: const TextStyle(fontSize: 18),
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
