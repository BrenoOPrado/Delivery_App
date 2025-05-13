import 'User.dart';
import 'Motorcycle.dart';

class MotoboyUser extends User {
  final Motorcycle motorcycle;
  final String workWallet;
  final String driverLicence;

  MotoboyUser({
    required int id,
    required String name,
    required String email,
    required int dddNumber,
    required int foneNumeber,
    required int assessment,
    required this.motorcycle,
    required this.workWallet,
    required this.driverLicence,
  }) : super(
         id: id,
         name: name,
         email: email,
         dddNumber: dddNumber,
         foneNumeber: foneNumeber,
         assessment: assessment,
       );
}
