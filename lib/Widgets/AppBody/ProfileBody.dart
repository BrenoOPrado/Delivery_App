import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  int userSelected = 0;
  final List<User> list = listUsers;

  int findUser(String username) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].name == username) {
        return i;
      }
    }
    return -1;
  }

  void alterUser(int userNumber) {
    if (userNumber >= 0 && userNumber < list.length) {
      setState(() {
        userSelected = userNumber;
      });
    }
  }

  final TextEditingController control = TextEditingController();

  @override
  void dispose() {
    control.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = list[this.userSelected];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.person, size: 120),
        Text(user.name, style: Theme.of(context).textTheme.headlineMedium),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                controller: control,
                decoration: const InputDecoration(
                  labelText: 'Digite algo',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final index = findUser(control.text);
                if (index != -1) {
                  alterUser(index);
                  control.text = "";
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Usuário não encontrado')),
                  );
                }
              },
              child: Icon(Icons.search),
            ),
          ],
        ),
      ],
    );
  }
}
