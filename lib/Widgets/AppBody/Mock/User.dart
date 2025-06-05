import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Order.dart';

class User {
  final int id;
  late String name;
  late String email;
  late int dddNumber;
  late int foneNumeber;
  late double assessment;
  late int numAssessment;
  late List<String> mensageBox;
  late List<Order> orders;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.dddNumber,
    required this.foneNumeber,
    required this.assessment,
    required this.numAssessment,
    required this.mensageBox,
    required this.orders,
  });
}
