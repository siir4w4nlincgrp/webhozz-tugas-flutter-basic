import 'package:flutter/material.dart';

class ModelMainMenu {
  String? tittle;
  IconData? icon;
  Color? color;
  String? routeName;

  ModelMainMenu(
    {
      this.tittle,
      this.icon,
      this.color,
      this.routeName
    }
  );

}

List<ModelMainMenu> tugasMainMenu() {
  List<ModelMainMenu> modelMainMenu = [];

  modelMainMenu.add(ModelMainMenu(
    tittle: "Order",
    icon: Icons.local_shipping,
    color: const Color(0xFFB71C1C),
    routeName: "/request-order",
  ));

  return modelMainMenu;

}