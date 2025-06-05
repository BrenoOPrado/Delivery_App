import 'dart:math';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Order.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';

class MotoboyRepository extends UserRepository {
  @override
  List<MotoboyUser> getAll() {
    return super.getAll().whereType<MotoboyUser>().toList();
  }

  void addMotoUser(MotoboyUser user) {
    listUsers.add(user);
  }

  void alterMotoUserById(int id, MotoboyUser user) {
    final index = listUsers.indexWhere((u) => u.id == id);
    if (index != -1) {
      listUsers[index] = user;
    }
  }

  void sendOrderMotoUser(Order order) {
    List<MotoboyUser> users = super.getAll().whereType<MotoboyUser>().toList();
    final random = Random().nextInt(users.length);

    super.addOrder(order);
    users[random].mensageBox.add("Novo pedido a ser entregue!");
  }
}
