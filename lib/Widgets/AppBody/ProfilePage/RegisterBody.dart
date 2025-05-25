import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ListUserRepositorie.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/Motorcycle.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

enum TipoCadastro { usuario, motoboy }

class Registerbody extends StatefulWidget {
  final Function alterUser;
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
  final TextEditingController controllName = TextEditingController();
  final TextEditingController controllEmail = TextEditingController();
  final TextEditingController controllDD = TextEditingController();
  final TextEditingController controllFone = TextEditingController();

  final TextEditingController controllWorkWallet = TextEditingController();
  final TextEditingController controllDriverLicence = TextEditingController();
  final TextEditingController controllBrand = TextEditingController();
  final TextEditingController controllPlate = TextEditingController();

  ListUserRepositorie rep = ListUserRepositorie();
  TipoCadastro tipoSelecionado = TipoCadastro.usuario;

  @override
  void dispose() {
    controllName.dispose();
    controllEmail.dispose();
    controllDD.dispose();
    controllFone.dispose();
    controllWorkWallet.dispose();
    controllDriverLicence.dispose();
    controllBrand.dispose();
    controllPlate.dispose();
    super.dispose();
  }

  void empyControll() {
    controllName.text = '';
    controllEmail.text = '';
    controllDD.text = '';
    controllFone.text = '';
    controllWorkWallet.text = '';
    controllDriverLicence.text = '';
    controllBrand.text = '';
    controllPlate.text = '';
  }

  User createUser(String name, String email, int dddNumber, int foneNumeber) {
    return User(
      id: rep.getAll().length,
      name: name,
      email: email,
      dddNumber: dddNumber,
      foneNumeber: foneNumeber,
      assessment: 0,
      numAssessment: 0,
    );
  }

  MotoboyUser createMotoUser(
    String name,
    String email,
    int dddNumber,
    int foneNumeber,
    String brand,
    String plate,
    String workWallet,
    String driverLicence,
  ) {
    return MotoboyUser(
      id: rep.getAll().length,
      name: name,
      email: email,
      dddNumber: dddNumber,
      foneNumeber: foneNumeber,
      assessment: 0,
      numAssessment: 0,
      motorcycle: Motorcycle(brand: brand, plate: plate),
      workWallet: workWallet,
      driverLicence: driverLicence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: controllName,
            decoration: const InputDecoration(
              labelText: 'Nome de usuario',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: controllEmail,
            decoration: const InputDecoration(
              labelText: 'Email do usuario',
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controllDD,
                  decoration: const InputDecoration(
                    labelText: 'DD',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controllFone,
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
                    controller: controllWorkWallet,
                    decoration: const InputDecoration(
                      labelText: 'Carteira de trabalho',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: controllDriverLicence,
                    decoration: const InputDecoration(
                      labelText: 'Carteira de motorista',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: controllBrand,
                    decoration: const InputDecoration(
                      labelText: 'Marca da motocicleta',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: controllPlate,
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
                  empyControll();
                  widget.alterPage(1);
                },
                child: Text("Voltar"),
              ),
              ElevatedButton(
                onPressed: () {
                  List<User> list = rep.getAll();
                  dynamic newUser;
                  bool isValid = true;
                  if (tipoSelecionado == TipoCadastro.usuario) {
                    newUser = createUser(
                      controllName.text,
                      controllEmail.text,
                      int.parse(controllDD.text),
                      int.parse(controllFone.text),
                    );
                  } else {
                    newUser = createMotoUser(
                      controllName.text,
                      controllEmail.text,
                      int.parse(controllDD.text),
                      int.parse(controllFone.text),
                      controllBrand.text,
                      controllPlate.text,
                      controllWorkWallet.text,
                      controllDriverLicence.text,
                    );
                  }

                  for (var i = 0; i < list.length; i++) {
                    if (list[i].name == newUser.name ||
                        list[i].email == newUser.email) {
                      isValid = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Usuário já existente')),
                      );
                    }
                  }

                  if (isValid) {
                    if (tipoSelecionado == TipoCadastro.usuario) {
                      rep.addUser(newUser);
                    } else {
                      rep.addMotoUser(newUser);
                    }
                    widget.alterUser(newUser.id);
                  }

                  empyControll();

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
