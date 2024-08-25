import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class OrderSearchFromMap extends StatefulWidget {
  const OrderSearchFromMap({super.key});

  @override
  State<OrderSearchFromMap> createState() => _OrderSearchFromMapState();
}

class _OrderSearchFromMapState extends State<OrderSearchFromMap> {
  final MapController _mapController = MapController();
  LatLng? _selectedLocation;
  final LatLng _defaultCenter = LatLng(-6.200000, 106.816666);
  double _zoomLevel = 9.2;

  Location location = Location();
  bool _isLoading = false;

  void _zoomIn() {
    setState(() {
      _zoomLevel = (_zoomLevel < 18.0) ? _zoomLevel + 1.0 : 18.0;
      _mapController.move(_mapController.center, _zoomLevel);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = (_zoomLevel > 1.0) ? _zoomLevel - 1.0 : 1.0;
      _mapController.move(_mapController.center, _zoomLevel);
    });
  }

  Future<void> _centerOnCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Memeriksa dan meminta izin lokasi
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location services are disabled')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permission not granted')),
          );
          setState(() {
            _isLoading = false;
          });
          return;
        }
      }

      // Mendapatkan lokasi saat ini
      final locationData = await location.getLocation();
      final currentLatLng = LatLng(locationData.latitude!, locationData.longitude!);

      // Arahkan peta ke lokasi saat ini
      setState(() {
        _mapController.move(currentLatLng, _zoomLevel);
        _selectedLocation = currentLatLng;
      });
    } catch (e) {
      // Tangani kesalahan, misalnya jika izin tidak diberikan atau gagal mendapatkan lokasi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to get current location')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.chevron_left, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text("Pilih Tujuan", style: TextStyle(color: Colors.black)),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _defaultCenter,
              zoom: _zoomLevel,
              onTap: (TapPosition tapPosition, LatLng latLng) {
                setState(() {
                  _selectedLocation = latLng;
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: "com.example.app",
              ),
              // const RichAttributionWidget(
              //   attributions: [
              //     TextSourceAttribution("OpenStreetMap contributors"),
              //   ],
              // ),
              if (_selectedLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _selectedLocation!,
                      builder: (ctx) => const Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (_isLoading)
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedLocation != null)
                  Text(
                    'Lokasi Terpilih: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                const SizedBox(height: 16),
                MaterialButton(
                  padding: const EdgeInsets.all(10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  minWidth: double.infinity,
                  onPressed: () {
                    if (_selectedLocation != null) {
                      Get.back(result: _selectedLocation);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a location')),
                      );
                    }
                  },
                  color: Colors.red,
                  child: const Text(
                    "Pilih Tujuan",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 16),
                // Controls for zooming and current location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.zoom_out),
                      onPressed: _zoomOut,
                    ),
                    Text('Zoom: ${_zoomLevel.toStringAsFixed(1)}'),
                    IconButton(
                      icon: const Icon(Icons.zoom_in),
                      onPressed: _zoomIn,
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: _centerOnCurrentLocation,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
