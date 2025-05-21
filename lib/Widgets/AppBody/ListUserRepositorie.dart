import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';

class Listuserrepositorie {
  final User baseUser = User(
    id: 0,
    name: "Usuario",
    email: "",
    dddNumber: 0,
    foneNumeber: 0,
    assessment: 0,
  );

  List<User> getAll() {
    try {
      return List<User>.from(listUsers);
    } catch (e) {
      return [baseUser];
    }
  }

  User getById(int id) {
    List<User> list = getAll();
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return list[i];
      }
    }
    return baseUser;
  }

  User getByName(String name) {
    List<User> list = getAll();
    for (var i = 0; i < list.length; i++) {
      if (list[i].name == name) {
        return list[i];
      }
    }
    return baseUser;
  }

  User getByEmail(String email) {
    List<User> list = getAll();
    for (var i = 0; i < list.length; i++) {
      if (list[i].email == email) {
        return list[i];
      }
    }
    return baseUser;
  }

  void deleteById(int id) {
    List<User> list = getAll();
    list.remove(getById(id));
  }

  void addUser(User user) {
    List<User>.from(listUsers).add(user);
  }

  void addMotoUser(MotoboyUser user) {
    List<User>.from(listUsers).add(user);
  }

  void alterUserById(int id, User user) {
    List<User> list = getAll();
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        List<User>.from(listUsers)[i] = user;
      }
    }
  }

  void alterMotoUserById(int id, MotoboyUser user) {
    List<User> list = getAll();
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        List<User>.from(listUsers)[i] = user;
      }
    }
  }
}
