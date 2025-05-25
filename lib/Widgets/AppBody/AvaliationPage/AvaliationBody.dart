import 'package:flutter/material.dart';

class AvaliationBody extends StatefulWidget {
  const AvaliationBody({super.key});

  @override
  State<AvaliationBody> createState() => _AvaliationBodyState();
}

class _AvaliationBodyState extends State<AvaliationBody> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Avaliação!'),
        const Text('Como avalia sua entrega?'),
        Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
