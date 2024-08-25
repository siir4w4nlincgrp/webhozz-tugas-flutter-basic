import 'package:linc_driver/tugas/tugas_index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LincDriver());
}

class LincDriver extends StatelessWidget {
  const LincDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return const TugasIndex();
  }
}
