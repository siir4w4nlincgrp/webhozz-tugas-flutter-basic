import 'package:linc_driver/tugas/controllers/contr_order_choose_price.dart';
import 'package:linc_driver/tugas/models/model_ride.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'order_summary.dart'; // Pastikan file ini diimport

class OrderChoosePrice extends StatefulWidget {
  const OrderChoosePrice({super.key});

  @override
  State<OrderChoosePrice> createState() => _OrderChoosePriceState();
}

class _OrderChoosePriceState extends State<OrderChoosePrice> {
  ContrOrderChoosePrice controller = Get.put(ContrOrderChoosePrice());
  late LatLng pickupLocation;
  late LatLng destinationLocation;
  MapController mapController = MapController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, LatLng>;
    pickupLocation = args['pickup'] ?? LatLng(-6.200000, 106.816666);
    destinationLocation = args['destination'] ?? LatLng(-6.200000, 106.816666);
  }

  void _zoomToLocations() async {
    setState(() {
      isLoading = true;
    });

    for (int i = 0; i < 2; i++) {
      mapController.move(mapController.center, mapController.zoom + 0.001);

      await Future.delayed(const Duration(milliseconds: 50));

      final bounds = LatLngBounds.fromPoints([
        pickupLocation,
        destinationLocation,
      ]);
      mapController.fitBounds(
        bounds,
        options: FitBoundsOptions(padding: EdgeInsets.all(16)),
      );

      await Future.delayed(const Duration(milliseconds: 50));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: LatLng(-6.200000, 106.816666),
                        zoom: 9.2,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: pickupLocation,
                              builder: (context) => const Icon(Icons.pin_drop, color: Color(0xFFB71C1C), size: 40),
                            ),
                            Marker(
                              point: destinationLocation,
                              builder: (context) => const Icon(Icons.pin_drop, color: Colors.blue, size: 40),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "${pickupLocation.latitude}, ${pickupLocation.longitude}",
                                style: const TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.arrow_forward),
                                ),
                              ),
                              TextSpan(
                                text: "${destinationLocation.latitude}, ${destinationLocation.longitude}",
                                style: const TextStyle(color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pilihan Harga"),
                      const SizedBox(height: 8),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.rides.listRide.length,
                                itemBuilder: (context, index) {
                                  ModelRide data = controller.rides.listRide[index];
                                  return GestureDetector(
                                    onTap: () {
                                      controller.setId(data.id);
                                    },
                                    child: Obx(
                                      () => Container(
                                        width: Get.width,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: controller.rides.id == data.id
                                              ? Color(0xFFB71C1C).withAlpha(30)
                                              : Colors.white,
                                          border: Border.all(
                                            color: controller.rides.id == data.id
                                                ? Colors.transparent
                                                : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data.title, style: TextStyle(fontWeight: FontWeight.bold)),
                                                Text(data.subTitle, style: TextStyle(color: Colors.grey)),
                                                const SizedBox(height: 16),
                                                Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(data.cost, style: TextStyle(color: Colors.black)),
                                                    const SizedBox(width: 20),
                                                    RichText(
                                                      textAlign: TextAlign.center,
                                                      text: TextSpan(
                                                        style: const TextStyle(color: Colors.black),
                                                        children: [
                                                          const WidgetSpan(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                              child: Icon(Icons.access_time_outlined, size: 16),
                                                            ),
                                                          ),
                                                          TextSpan(text: data.time),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Image.asset(
                                              data.image!,
                                              height: 70,
                                              width: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                padding: const EdgeInsets.all(10),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                onPressed: () {
                  final selectedRide = controller.rides.listRide.firstWhere(
                    (ride) => ride.id == controller.rides.id.value,
                    orElse: () => ModelRide(
                      id: -1, // ID tidak valid
                      title: '',
                      subTitle: '',
                      cost: '',
                      time: '',
                      image: '',
                    ),
                  );

                  if (selectedRide.id != -1) { // Pastikan ID valid
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrderSummary(
                          pickupLocation: pickupLocation,
                          destinationLocation: destinationLocation,
                          selectedRide: selectedRide,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Mobil yang dipilih tidak valid.')),
                    );
                  }
                },
                height: 45,
                color: Color(0xFFB71C1C),
                child: const Text(
                  'Buat Pesanan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _zoomToLocations,
        backgroundColor: Color(0xFFB71C1C),
        child: const Icon(Icons.zoom_in_map, color: Colors.white),
      ),
    );
  }
}
