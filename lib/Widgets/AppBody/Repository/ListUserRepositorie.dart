import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'dart:math';

class ListUserRepositorie {
  List<User> getAll() {
    return listUsers;
  }

  User getBaseUser() {
    return baseUser;
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

  void addAssessmentById(double assessment, int id) {
    var user = getById(id);
    int index = listUsers.indexOf(user);
    double newAssessment = assessment;

    if (user.numAssessment <= 0) {
      user.numAssessment = 1;
    } else {
      newAssessment = (((user.assessment * user.numAssessment) + assessment) /
              (user.numAssessment + 1))
          .clamp(0, 5);
      user.numAssessment += 1;
    }
    user.assessment = newAssessment;
    listUsers[index] = user;
  }

  void sendMensageUser(String mensage) {
    List<User> users = getAll();
    var index = 0;

    users.forEach((user) {
      if (user.id > 1) {
        user.mensageBox.add(mensage);
        listUsers[index] = user;
      }
      index += 1;
    });
  }

  void sendOrderMotoUser(String mensage) {
    List<User> users = getAll();
    users.whereType<MotoboyUser>();

    final random = Random();

    users[random.nextInt(users.length)].mensageBox.add(mensage);
  }
}
