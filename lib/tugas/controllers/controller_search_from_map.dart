import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ControllerSearchFromMap extends GetxController {
  // Menyimpan instance Markers yang dapat diobservasi
  var markers = Markers().obs;
}

class Markers {
  // Menyimpan titik pusat dengan nilai default yang dapat diobservasi
  var center = LatLng(-6.200000, 106.816666).obs;
}
