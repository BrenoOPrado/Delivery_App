import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ListUserRepositorie.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

class Loginbody extends StatefulWidget {
  final Function alterUser;
  final Function(int) alterPage;

  const Loginbody({
    super.key,
    required this.alterUser,
    required this.alterPage,
  });

  @override
  State<Loginbody> createState() => _Loginbody();
}

class _Loginbody extends State<Loginbody> {
  final TextEditingController controlUser = TextEditingController();
  Listuserrepositorie rep = Listuserrepositorie();

  @override
  void dispose() {
    controlUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controlUser,
              decoration: const InputDecoration(
                labelText: 'Nome de usuario',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.alterPage(0);
                },
                child: Text("Voltar"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.alterPage(2);
                },
                child: Text("Cadastrar-se"),
              ),
              ElevatedButton(
                onPressed: () {
                  final User user = rep.getByName(controlUser.text);
                  if (user != Null) {
                    widget.alterUser(user.id);
                    controlUser.text = "";
                    widget.alterPage(0);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Usuário não encontrado')),
                    );
                  }
                },
                child: Text("Entrar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
