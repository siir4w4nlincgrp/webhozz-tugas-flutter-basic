import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:linc_driver/tugas/models/model_ride.dart';

class OrderSummary extends StatelessWidget {
  final LatLng pickupLocation;
  final LatLng destinationLocation;
  final ModelRide selectedRide;

  const OrderSummary({
    Key? key,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.selectedRide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Pesanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informasi Pesanan',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Lokasi Jemput: ${pickupLocation.latitude}, ${pickupLocation.longitude}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Lokasi Tujuan: ${destinationLocation.latitude}, ${destinationLocation.longitude}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Mobil yang Dipilih:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              selectedRide.title,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              selectedRide.subTitle,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              selectedRide.cost,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Waktu: ${selectedRide.time}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Image.asset(
              selectedRide.image!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
