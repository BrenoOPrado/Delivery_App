import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Order.dart';

import 'User.dart';
import 'Motorcycle.dart';

class MotoboyUser extends User {
  late Motorcycle motorcycle;
  late String workWallet;
  late String driverLicence;
  late List<Order> toDelivery;

  MotoboyUser({
    required int id,
    required String name,
    required String email,
    required int dddNumber,
    required int foneNumeber,
    required double assessment,
    required int numAssessment,
    required List<String> mensageBox,
    required List<Order> orders,
    required this.motorcycle,
    required this.workWallet,
    required this.driverLicence,
    required this.toDelivery,
  }) : super(
         id: id,
         name: name,
         email: email,
         dddNumber: dddNumber,
         foneNumeber: foneNumeber,
         assessment: assessment,
         numAssessment: numAssessment,
         mensageBox: mensageBox,
         orders: orders,
       );
}
