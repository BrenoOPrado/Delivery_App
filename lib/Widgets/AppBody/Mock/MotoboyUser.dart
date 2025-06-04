import 'User.dart';
import 'Motorcycle.dart';

class MotoboyUser extends User {
  late Motorcycle motorcycle;
  late String workWallet;
  late String driverLicence;

  MotoboyUser({
    required int id,
    required String name,
    required String email,
    required int dddNumber,
    required int foneNumeber,
    required double assessment,
    required int numAssessment,
    required List<String> mensageBox,
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
         numAssessment: numAssessment,
         mensageBox: mensageBox,
       );
}
