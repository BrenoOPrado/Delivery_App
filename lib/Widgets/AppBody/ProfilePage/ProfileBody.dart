import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ProfilePage/LoginBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ProfilePage/PersonBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ProfilePage/RegisterBody.dart';

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

  void alterPage(int page) {
    if (page >= 0 && page < 3) {
      setState(() {
        profilePage = page;
      });
    }
  }

  Widget _getBody() {
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
        return Registerbody(alterUser: widget.alterUser, alterPage: alterPage);
      default:
        return const Center(
          child: Text(
            'Página não encontrada',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: Padding(
          key: ValueKey(profilePage),
          padding: const EdgeInsets.all(20),
          child: _getBody(),
        ),
      ),
    );
  }
}
