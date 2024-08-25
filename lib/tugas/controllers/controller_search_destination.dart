import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ControllerSearchDestination extends GetxController {
  // Rxn<LatLng> digunakan untuk menangani lokasi saat ini yang dapat berupa null
  var currentLocation = Rxn<LatLng>();

  // Metode untuk memperbarui lokasi saat ini
  void updateCurrentLocation(LatLng location) {
    currentLocation.value = location;
  }
}
