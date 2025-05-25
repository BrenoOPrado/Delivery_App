import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/MotoboyUser.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';

class PersonBody extends StatefulWidget {
  final User user;
  final Function(int) alterPage;

  const PersonBody({super.key, required this.user, required this.alterPage});

  @override
  State<PersonBody> createState() => _PersonBody();
}

class _PersonBody extends State<PersonBody> {
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
          ],
        ),
      ),
    );
  }
}
