import 'package:linc_driver/tugas/tugas_routes.dart';
import 'package:linc_driver/tugas/views/view_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TugasIndex extends StatelessWidget {
  const TugasIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      defaultTransition: Transition.zoom,
      home: const TugasSplash(),

    );
  }
}