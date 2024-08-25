import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:linc_driver/tugas/models/model_ride.dart';
import 'package:get/get.dart'; // Untuk navigasi dengan GetX

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
        backgroundColor: const Color(0xFFB71C1C),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pesanan ID 4743638232632',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildReadOnlyFormField(
              label: 'Lokasi Jemput',
              value: '${pickupLocation.latitude}, ${pickupLocation.longitude}',
            ),
            const SizedBox(height: 16), // Jarak lebih besar antara elemen
            _buildReadOnlyFormField(
              label: 'Lokasi Tujuan',
              value: '${destinationLocation.latitude}, ${destinationLocation.longitude}',
            ),
            const SizedBox(height: 16),
            _buildReadOnlyFormField(
              label: 'Mobil yang Dipilih',
              value: selectedRide.title,
            ),
            const SizedBox(height: 16),
            _buildReadOnlyFormField(
              label: 'Jumlah Penumpang',
              value: selectedRide.subTitle,
            ),
            _buildReadOnlyFormField(
              label: 'Biaya',
              value: selectedRide.cost,
            ),
            _buildReadOnlyFormField(
              label: 'Estimasi Waktu Jemput',
              value: selectedRide.time,
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Get.offAllNamed('home'); // Navigasi ke halaman home dan hapus semua halaman sebelumnya
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFB71C1C), // Warna tombol merah
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
            ),
            child: const Text(
              'Back to Home',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyFormField({
    required String label,
    required String value,
  }) {
    return TextFormField(
      readOnly: true,
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: InputBorder.none, // Menghilangkan outline
        filled: true,
        fillColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 18),
    );
  }
}
