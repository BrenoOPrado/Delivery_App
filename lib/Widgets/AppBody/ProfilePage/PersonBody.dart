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
  UserRepository rep = UserRepository();
  int userSelected = 0;

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
        actions: [
          ElevatedButton(
            onPressed: () {
              widget.alterPage(1);
            },
            child: Text("Entrar"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.person, size: 120),
            Text(
              widget.user.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              widget.user.email,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            widget.user.foneNumeber == 0
                ? SizedBox.shrink()
                : Text(
                  '(${(widget.user.dddNumber)}) ${(widget.user.foneNumeber)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            SizedBox(height: 10),
            widget.user is MotoboyUser
                ? Column(
                  children: [
                    Text(
                      'Moto:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Column(
                      children: [
                        Text(
                          'Marca: ${(widget.user as MotoboyUser).motorcycle.brand}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Placa: ${(widget.user as MotoboyUser).motorcycle.plate}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Carteira de trabalho: ${(widget.user as MotoboyUser).workWallet}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Carteira de Motorista: ${(widget.user as MotoboyUser).driverLicence}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
                : SizedBox.shrink(),
            SizedBox(height: 10),
            Text('Avaliação: ', style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Icon(
                  index < clampedRating ? Icons.star : Icons.star_border,
                  color: index < clampedRating ? Colors.amber : Colors.grey,
                );
              }),
            ),
            SizedBox(height: 10),
            Text(
              'Caixa de mensagens: (${widget.user.mensageBox.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 10),
            widget.user.mensageBox.isEmpty
                ? Text(
                  'Nenhuma mensagem disponível.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
                : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            (widget.user.id == 1)
                ? ElevatedButton(
                  child: Text('Enviar Mensagem aos usuários'),
                  onPressed: () {
                    TextEditingController _controller = TextEditingController();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Nova mensagem'),
                          content: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Digite a mensagem',
                            ),
                            maxLines: 3,
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              child: Text('Enviar'),
                              onPressed: () {
                                final mensagem = _controller.text.trim();
                                if (mensagem.isNotEmpty) {
                                  rep.sendMensageUser(mensagem);
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
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
                )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
