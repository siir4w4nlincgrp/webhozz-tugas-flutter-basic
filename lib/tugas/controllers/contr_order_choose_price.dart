import 'package:linc_driver/tugas/models/model_ride.dart';
import 'package:get/get.dart';

class ContrOrderChoosePrice extends GetxController {
  var rides = Rides();

  void setId(int id) {
    rides.id.value = id;
  }

}

class Rides {
  var listRide  = listRides().obs;
  var id        = 0.obs;
}