import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/MotoboyRepository.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';
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
  State<Registerbody> createState() => _RegisterbodyState();
}

class _RegisterbodyState extends State<Registerbody> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController ddCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();

  final TextEditingController walletCtrl = TextEditingController();
  final TextEditingController licenseCtrl = TextEditingController();
  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController plateCtrl = TextEditingController();

  TipoCadastro tipoSelecionado = TipoCadastro.usuario;

  final UserRepository repUser = UserRepository();
  final MotoboyRepository repMoto = MotoboyRepository();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    ddCtrl.dispose();
    phoneCtrl.dispose();
    walletCtrl.dispose();
    licenseCtrl.dispose();
    brandCtrl.dispose();
    plateCtrl.dispose();
    super.dispose();
  }

  void clearAllFields() {
    nameCtrl.clear();
    emailCtrl.clear();
    ddCtrl.clear();
    phoneCtrl.clear();
    walletCtrl.clear();
    licenseCtrl.clear();
    brandCtrl.clear();
    plateCtrl.clear();
  }

  User createUser() {
    return User(
      id: repUser.getAll().length,
      name: nameCtrl.text,
      email: emailCtrl.text,
      dddNumber: int.tryParse(ddCtrl.text) ?? 0,
      foneNumeber: int.tryParse(phoneCtrl.text) ?? 0,
      assessment: 0,
      numAssessment: 0,
      mensageBox: [],
      orders: [],
    );
  }

  MotoboyUser createMotoUser() {
    return MotoboyUser(
      id: repUser.getAll().length,
      name: nameCtrl.text,
      email: emailCtrl.text,
      dddNumber: int.tryParse(ddCtrl.text) ?? 0,
      foneNumeber: int.tryParse(phoneCtrl.text) ?? 0,
      assessment: 0,
      numAssessment: 0,
      mensageBox: [],
      orders: [],
      motorcycle: Motorcycle(brand: brandCtrl.text, plate: plateCtrl.text),
      workWallet: walletCtrl.text,
      driverLicence: licenseCtrl.text,
      toDelivery: [],
    );
  }

  void register() {
    final existingUsers = repUser.getAll();

    dynamic newUser =
        tipoSelecionado == TipoCadastro.usuario
            ? createUser()
            : createMotoUser();

    final exists = existingUsers.any(
      (u) =>
          u.name == newUser.name ||
          u.email.toLowerCase() == newUser.email.toLowerCase(),
    );

    if (exists) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Usuário já existente')));
      return;
    }

    if (tipoSelecionado == TipoCadastro.usuario) {
      repUser.addUser(newUser);
    } else {
      repMoto.addMotoUser(newUser);
    }

    widget.alterUser(newUser.id);
    clearAllFields();
    widget.alterPage(0);
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCadastroTipoRadio(TipoCadastro tipo, String title) {
    return RadioListTile<TipoCadastro>(
      title: Text(title),
      value: tipo,
      groupValue: tipoSelecionado,
      onChanged: (TipoCadastro? valor) {
        setState(() {
          tipoSelecionado = valor!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro'), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth > 600 ? 500 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Cadastre-se como Usuário ou Motoboy",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(nameCtrl, 'Nome de usuário'),
                    const SizedBox(height: 12),
                    _buildTextField(emailCtrl, 'Email'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(ddCtrl, 'DDD')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField(phoneCtrl, 'Telefone')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildCadastroTipoRadio(
                      TipoCadastro.usuario,
                      'Cadastrar como Usuário',
                    ),
                    _buildCadastroTipoRadio(
                      TipoCadastro.motoboy,
                      'Cadastrar como Motoboy',
                    ),
                    if (tipoSelecionado == TipoCadastro.motoboy) ...[
                      const SizedBox(height: 12),
                      _buildTextField(walletCtrl, 'Carteira de trabalho'),
                      const SizedBox(height: 12),
                      _buildTextField(licenseCtrl, 'Carteira de motorista'),
                      const SizedBox(height: 12),
                      _buildTextField(brandCtrl, 'Marca da moto'),
                      const SizedBox(height: 12),
                      _buildTextField(plateCtrl, 'Placa da moto'),
                    ],
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              clearAllFields();
                              widget.alterPage(1);
                            },
                            icon: const Icon(Icons.arrow_back),
                            label: const Text("Voltar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400,
                              foregroundColor: Colors.black87,
                              minimumSize: const Size.fromHeight(48),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: register,
                            icon: const Icon(Icons.check),
                            label: const Text("Cadastrar"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(48),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
