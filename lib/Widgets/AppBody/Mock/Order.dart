import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Pizza.dart';

class Order {
  final int id;
  late int idUser;
  late int idMotoUser;
  late List<Pizza> pizza;

  Order({
    required this.id,
    required this.idUser,
    required this.idMotoUser,
    required this.pizza,
  });
}
