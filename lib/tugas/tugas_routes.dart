import 'package:linc_driver/main.dart';
import 'package:linc_driver/tugas/views/orders/order_choose_price.dart';
import 'package:linc_driver/tugas/views/orders/order_request.dart';
import 'package:linc_driver/tugas/views/orders/order_search_destination.dart';
import 'package:linc_driver/tugas/views/orders/order_search_from_map.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:linc_driver/tugas/views/view_home.dart';

List<GetPage<dynamic>> routes = [

  GetPage(name: "/", page: () => const LincDriver()),
  GetPage(name: "/request-order", page: () => const OrderRequest()),
  GetPage(name: "/search-destination", page: () => const OrderSearchDestination()),
  GetPage(name: "/search-from-map", page: () => const OrderSearchFromMap()),
  GetPage(name: "/order-choose-price", page: () => const OrderChoosePrice()),
  GetPage(name: "/home", page: () => const ViewHome()),

];