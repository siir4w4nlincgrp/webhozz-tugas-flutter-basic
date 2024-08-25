import 'package:flutter/material.dart';

InputDecoration myDecoration(String hint, Icon icon, {IconButton? suffix}) {
  return InputDecoration(
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    fillColor: const Color(0xFFB71C1C).withOpacity(0.1), // Ganti warna form input menjadi merah tua
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide.none, // Hilangkan border untuk state enabled
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide.none, // Hilangkan border untuk state focused
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.red), // Border merah untuk state error
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: Colors.red), // Border merah untuk state focused error
    ),
    prefixIcon: icon,
    suffixIcon: suffix,
    filled: true,
  );
}

Widget myDottedLine(double height) {
  return SizedBox(
    height: height,
    child: LayoutBuilder(
      builder: (context, constraints) {
        double boxHeight = constraints.maxHeight;
        double dashWidth = 2.0;
        double dashHeight = 2.0;
        int dashCount = (boxHeight / (2 * dashHeight)).floor();
        return Flex(
          direction: Axis.vertical,
          children: List.generate(
            dashCount,
            (_) => SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
        );
      },
    ),
  );
}
