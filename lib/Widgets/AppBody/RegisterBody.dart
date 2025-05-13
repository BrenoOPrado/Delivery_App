import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/ListUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

enum TipoCadastro { usuario, motoboy }

class Registerbody extends StatefulWidget {
  final Function(int) alterUser;
  final Function(int) alterPage;

  const Registerbody({
    super.key,
    required this.alterUser,
    required this.alterPage,
  });

  @override
  State<Registerbody> createState() => _Registerbody();
}

class _Registerbody extends State<Registerbody> {
  final TextEditingController controlUser = TextEditingController();
  final List<User> list = listUsers;
  TipoCadastro tipoSelecionado = TipoCadastro.usuario;

  @override
  void dispose() {
    controlUser.dispose();
    super.dispose();
  }

  int findUser(String username) {
    for (var i = 0; i < list.length; i++) {
      if (list[i].name == username) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controlUser,
            decoration: const InputDecoration(
              labelText: 'Nome de usuario',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            //controller: controlUser,
            decoration: const InputDecoration(
              labelText: 'Email do usuario',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'DD',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),

          RadioListTile<TipoCadastro>(
            title: const Text('Cadastrar como Usuário'),
            value: TipoCadastro.usuario,
            groupValue: tipoSelecionado,
            onChanged: (TipoCadastro? valor) {
              setState(() {
                tipoSelecionado = valor!;
              });
            },
          ),
          RadioListTile<TipoCadastro>(
            title: const Text('Cadastrar como Motoboy'),
            value: TipoCadastro.motoboy,
            groupValue: tipoSelecionado,
            onChanged: (TipoCadastro? valor) {
              setState(() {
                tipoSelecionado = valor!;
              });
            },
          ),
          tipoSelecionado == TipoCadastro.usuario
              ? SizedBox.shrink()
              : (Column(
                children: [
                  TextField(
                    //controller: controlUser,
                    decoration: const InputDecoration(
                      labelText: 'Carteira de trabalho',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    //controller: controlUser,
                    decoration: const InputDecoration(
                      labelText: 'Carteira de motorista',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    //controller: controlUser,
                    decoration: const InputDecoration(
                      labelText: 'Marca da motocicleta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    //controller: controlUser,
                    decoration: const InputDecoration(
                      labelText: 'Placa da motocicleta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.alterPage(1);
                },
                child: Text("Voltar"),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.alterPage(0);
                },
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
