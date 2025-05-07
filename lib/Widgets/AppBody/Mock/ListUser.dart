import 'User.dart';
import 'MotoboyUser.dart';
import 'Motorcycle.dart';

final List<User> listUsers = [
  User(id: 0, name: "Usuario", email: "", dddNumber: 0, foneNumeber: 0),
  User(
    id: 1,
    name: "Felipe Prettu",
    email: "felipe.preto@hotmail.com",
    dddNumber: 11,
    foneNumeber: 999999999,
  ),
  User(
    id: 2,
    name: "Leticia",
    email: "leticia@gmail.com",
    dddNumber: 11,
    foneNumeber: 888888888,
  ),
  MotoboyUser(
    id: 3,
    name: "Breno Prado",
    email: "breno.prado@hotmail.com",
    dddNumber: 11,
    foneNumeber: 000000000,
    motorcycle: Motorcycle(brand: "Yamaha", plate: "ABC-0D12"),
    workWallet: "123456789123",
    driverLicence: "123456789123",
  ),
];
