import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListPizza.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Order.dart';

import 'User.dart';
import 'MotoboyUser.dart';
import 'Motorcycle.dart';

final User baseUser = User(
  id: 0,
  name: "Usuario",
  email: "",
  dddNumber: 0,
  foneNumeber: 0,
  assessment: 0,
  numAssessment: 0,
  mensageBox: [],
  orders: [],
);

final List<User> listUsers = [
  baseUser,
  User(
    id: 1,
    name: "PIZZA",
    email: "pizza.delivery@hotmail.com",
    dddNumber: 00,
    foneNumeber: 000000000,
    assessment: 5,
    numAssessment: 1,
    mensageBox: ["Perfil da Pizzaria"],
    orders: [],
  ),
  MotoboyUser(
    id: 2,
    name: "Breno Prado",
    email: "breno.prado@hotmail.com",
    dddNumber: 11,
    foneNumeber: 111111111,
    assessment: 5,
    numAssessment: 7,
    mensageBox: [],
    orders: [],
    motorcycle: Motorcycle(brand: "Moto", plate: "ABC-0D12"),
    workWallet: "123456789123",
    driverLicence: "123456789123",
    toDelivery: [],
  ),
  User(
    id: 3,
    name: "Felipe",
    email: "felipe@gmail.com",
    dddNumber: 22,
    foneNumeber: 222222222,
    assessment: 3,
    numAssessment: 4,
    mensageBox: [],
    orders: [
      Order(
        id: 1,
        idUser: 3,
        idMotoUser: 2,
        pizza: [listPizza[0], listPizza[3]],
        delivered: false,
      ),
      Order(
        id: 2,
        idUser: 3,
        idMotoUser: null,
        pizza: [listPizza[1], listPizza[5], listPizza[9]],
        delivered: false,
      ),
      Order(
        id: 3,
        idUser: 3,
        idMotoUser: 2,
        pizza: [listPizza[6]],
        delivered: true,
      ),
      Order(
        id: 4,
        idUser: 3,
        idMotoUser: 2,
        pizza: [listPizza[2], listPizza[7], listPizza[8]],
        delivered: true,
      ),
    ],
  ),
  User(
    id: 4,
    name: "Ana Clara",
    email: "ana.clara@gmail.com",
    dddNumber: 33,
    foneNumeber: 333333333,
    assessment: 5,
    numAssessment: 1,
    mensageBox: [],
    orders: [],
  ),
  User(
    id: 4,
    name: "Ana Ayslin",
    email: "ana.ayslin@gmail.com",
    dddNumber: 44,
    foneNumeber: 444444444,
    assessment: 5,
    numAssessment: 1,
    mensageBox: [],
    orders: [],
  ),
];
