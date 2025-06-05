import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';
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
  State<Loginbody> createState() => _LoginbodyState();
}

class _LoginbodyState extends State<Loginbody> {
  final TextEditingController controlUser = TextEditingController();
  final UserRepository rep = UserRepository();

  @override
  void dispose() {
    controlUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define largura máxima do formulário para telas maiores
        double maxWidth =
            constraints.maxWidth > 600 ? 400 : constraints.maxWidth * 0.9;

        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controlUser,
                    decoration: InputDecoration(
                      labelText: 'Nome de usuário',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      SizedBox(
                        width: maxWidth * 0.28,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            widget.alterPage(0);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                          child: Text(
                            "Voltar",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: maxWidth * 0.28,
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () {
                            widget.alterPage(2);
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(color: Colors.deepOrange),
                          ),
                          child: Text(
                            "Cadastrar-se",
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: maxWidth * 0.28,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            final User? user = rep.getByName(controlUser.text);
                            if (user != null) {
                              widget.alterUser(user.id);
                              controlUser.clear();
                              widget.alterPage(0);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Usuário não encontrado'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.black),
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
    );
  }
}
