import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';

class PersonBody extends StatefulWidget {
  final User user;
  final Function(int) alterPage;

  const PersonBody({super.key, required this.user, required this.alterPage});

  @override
  State<PersonBody> createState() => _PersonBody();
}

class _PersonBody extends State<PersonBody> {
  final UserRepository rep = UserRepository();

  @override
  void didUpdateWidget(covariant PersonBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.user != widget.user) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final int clampedRating = widget.user.assessment.round().clamp(0, 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do Usuário"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            tooltip: "Ir para login",
            onPressed: () => widget.alterPage(1),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.person, size: 120, color: Colors.deepOrange),
              const SizedBox(height: 16),
              Text(
                widget.user.name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                widget.user.email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (widget.user.foneNumeber != 0)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    '(${widget.user.dddNumber}) ${widget.user.foneNumeber}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              const SizedBox(height: 16),

              if (widget.user is MotoboyUser)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    Text(
                      'Moto:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Marca: ${(widget.user as MotoboyUser).motorcycle.brand}',
                    ),
                    Text(
                      'Placa: ${(widget.user as MotoboyUser).motorcycle.plate}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Carteira de trabalho: ${(widget.user as MotoboyUser).workWallet}',
                    ),
                    Text(
                      'Carteira de Motorista: ${(widget.user as MotoboyUser).driverLicence}',
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

              const Divider(),

              Text(
                'Avaliação:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  return Icon(
                    index < clampedRating ? Icons.star : Icons.star_border,
                    color: index < clampedRating ? Colors.amber : Colors.grey,
                  );
                }),
              ),
              const SizedBox(height: 20),

              Text(
                'Caixa de mensagens (${widget.user.mensageBox.length})',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),

              if (widget.user.mensageBox.isEmpty)
                Text(
                  'Nenhuma mensagem disponível.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              else
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.user.mensageBox.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}. ',
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  widget.user.mensageBox[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 20),

              if (widget.user.id == 1)
                ElevatedButton.icon(
                  icon: const Icon(Icons.message),
                  label: const Text('Enviar mensagem aos usuários'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () {
                    final TextEditingController _controller =
                        TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Nova mensagem'),
                          content: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              hintText: 'Digite a mensagem',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepOrange,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Enviar'),
                              onPressed: () {
                                final mensagem = _controller.text.trim();
                                if (mensagem.isNotEmpty) {
                                  rep.sendMensageUser(mensagem);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Mensagem enviada!'),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
