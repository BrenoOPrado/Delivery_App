import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';

class ListUserRepositorie {
  final User baseUser = User(
    id: 0,
    name: "Usuario",
    email: "",
    dddNumber: 0,
    foneNumeber: 0,
    assessment: 0,
  );

  List<User> getAll() {
    return listUsers;
  }

  User getById(int id) {
    return listUsers.firstWhere(
      (user) => user.id == id,
      orElse: () => baseUser,
    );
  }

  User getByName(String name) {
    return listUsers.firstWhere(
      (user) => user.name == name,
      orElse: () => baseUser,
    );
  }

  User getByEmail(String email) {
    return listUsers.firstWhere(
      (user) => user.email == email,
      orElse: () => baseUser,
    );
  }

  void deleteById(int id) {
    listUsers.removeWhere((user) => user.id == id);
  }

  void addUser(User user) {
    listUsers.add(user);
  }

  void addMotoUser(MotoboyUser user) {
    listUsers.add(user);
  }

  void alterUserById(int id, User user) {
    final index = listUsers.indexWhere((u) => u.id == id);
    if (index != -1) {
      listUsers[index] = user;
    }
  }

  void alterMotoUserById(int id, MotoboyUser user) {
    final index = listUsers.indexWhere((u) => u.id == id);
    if (index != -1) {
      listUsers[index] = user;
    }
  }
}
