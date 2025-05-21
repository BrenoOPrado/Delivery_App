import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/LoginBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/PersonBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/RegisterBody.dart';

class ProfileBody extends StatefulWidget {
  final Function alterUser;
  final User user;

  const ProfileBody({super.key, required this.alterUser, required this.user});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  int profilePage = 0;

  final TextEditingController controlUser = TextEditingController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Widget getBody() {
      switch (profilePage) {
        case 0:
          return PersonBody(
            key: ValueKey(widget.user.id),
            user: widget.user,
            alterPage: alterPage,
          );
        case 1:
          return Loginbody(alterUser: widget.alterUser, alterPage: alterPage);
        case 2:
          return Registerbody(
            alterUser: widget.alterUser,
            alterPage: alterPage,
          );
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
