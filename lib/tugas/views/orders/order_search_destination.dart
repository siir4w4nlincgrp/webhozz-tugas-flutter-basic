import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart'; // Untuk Clipboard

class OrderSearchDestination extends StatefulWidget {
  const OrderSearchDestination({super.key});

  @override
  State<OrderSearchDestination> createState() => _OrderSearchDestinationState();
}

class _OrderSearchDestinationState extends State<OrderSearchDestination> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  String _activeField = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final LatLng? location = Get.arguments as LatLng?;
      if (location != null) {
        if (_activeField == 'pickup') {
          _pickupController.text = '${location.latitude}, ${location.longitude}';
        } else if (_activeField == 'destination') {
          _destinationController.text = '${location.latitude}, ${location.longitude}';
        }
      }
    });
  }

  void _navigateToMap(String field) {
    setState(() {
      _activeField = field;
    });
    Get.toNamed("search-from-map")?.then((result) {
      if (result is LatLng) {
        if (_activeField == 'pickup') {
          _pickupController.text = '${result.latitude}, ${result.longitude}';
        } else if (_activeField == 'destination') {
          _destinationController.text = '${result.latitude}, ${result.longitude}';
        }
      }
    });
  }

  void _navigateToOrderChoosePrice() {
    final pickupLocation = _pickupController.text.split(', ').map(double.tryParse).toList();
    final destinationLocation = _destinationController.text.split(', ').map(double.tryParse).toList();

    // Validasi untuk memastikan lokasi jemput dan tujuan telah diinput
    if (_pickupController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap masukkan lokasi jemput dan tujuan')),
      );
      return;
    }

    // Validasi untuk memastikan format lokasi benar
    if (pickupLocation.length == 2 && destinationLocation.length == 2) {
      final pickupLatLng = LatLng(pickupLocation[0]!, pickupLocation[1]!);
      final destinationLatLng = LatLng(destinationLocation[0]!, destinationLocation[1]!);

      Get.toNamed("order-choose-price", arguments: {
        'pickup': pickupLatLng,
        'destination': destinationLatLng,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap masukkan lokasi jemput dan tujuan dengan format yang benar')),
      );
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Teks disalin ke clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Menjaga warna merah
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          "Cari Lokasi Jemput dan Tujuan",
          style: const TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _pickupController,
              readOnly: true, // Membuat input menjadi read-only
              decoration: InputDecoration(
                labelText: "Lokasi Jemput",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: const Color(0xFFB71C1C)),
                ),
                prefixIcon: const Icon(Icons.location_on, color: Color(0xFFB71C1C)),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.map, color: Color(0xFFB71C1C)),
                      onPressed: () => _navigateToMap('pickup'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Color(0xFFB71C1C)),
                      onPressed: () => _copyToClipboard(_pickupController.text),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _destinationController,
              readOnly: true, // Membuat input menjadi read-only
              decoration: InputDecoration(
                labelText: "Lokasi Tujuan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: const Color(0xFFB71C1C)),
                ),
                prefixIcon: const Icon(Icons.location_on, color: Color(0xFFB71C1C)),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.map, color: Color(0xFFB71C1C)),
                      onPressed: () => _navigateToMap('destination'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, color: Color(0xFFB71C1C)),
                      onPressed: () => _copyToClipboard(_destinationController.text),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _navigateToOrderChoosePrice,
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFB71C1C), // Button color
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text("Selanjutnya"),
            ),
          ],
        ),
      ),
    );
  }
}
