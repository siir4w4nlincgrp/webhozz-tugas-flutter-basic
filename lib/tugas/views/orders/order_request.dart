import 'package:linc_driver/tugas/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRequest extends StatefulWidget {
  const OrderRequest({super.key});

  @override
  State<OrderRequest> createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  String name = '';

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: constraints.maxWidth),
              child: Text(
                "Mau ke mana, $name ?",
                style: const TextStyle(fontSize: 16), // Menyesuaikan ukuran font
                overflow: TextOverflow.visible // Menambahkan overflow
              ),
            );
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
              center : LatLng(-6.200000, 106.816666),
              zoom : 9.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: "com.example.app",
              ),
              const RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    "OpenStreetMap contributors",
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Halo, Mau Pesan Ke Tujuan Mana ?"),
                const SizedBox(height: 20),
                TextField(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Get.toNamed("/search-destination");
                  },
                  decoration: myDecoration(
                    "Cari lokasi tujuan", const Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
