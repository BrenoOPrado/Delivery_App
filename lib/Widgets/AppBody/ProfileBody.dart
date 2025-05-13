import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/LoginBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/PersonBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/RegisterBody.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  int userSelected = 0;
  int profilePage = 0;
  List<User> list = listUsers;

  final TextEditingController controlUser = TextEditingController();

  @override
  void initState() {
    super.initState();
    getList(); // apenas uma vez ao iniciar
  }

  void getList() {
    setState(() {
      list = List<User>.from(listUsers);
    });
  }

  @override
  void dispose() {
    controlUser.dispose();
    super.dispose();
  }

  void alterPage(int page) {
    if (page >= 0 && page < 3) {
      setState(() {
        profilePage = page;
      });
    }
  }

  void alterUser(int userNumber) {
    if (userNumber >= 0 && userNumber < list.length) {
      setState(() {
        userSelected = userNumber;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = list[userSelected];

    Widget getBody() {
      switch (profilePage) {
        case 0:
          return PersonBody(
            key: ValueKey(user.id),
            user: user,
            alterPage: alterPage,
          );
        case 1:
          return Loginbody(alterUser: alterUser, alterPage: alterPage);
        case 2:
          return Registerbody(alterUser: alterUser, alterPage: alterPage);
        default:
          return const Text('Página não encontrada');
      }
    }

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: getBody(),
    );
  }
}
