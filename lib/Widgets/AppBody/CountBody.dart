import 'package:flutter/material.dart';

class CountBody extends StatefulWidget {
  const CountBody({super.key});

  @override
  State<CountBody> createState() => _CountBodyState();
}

class _CountBodyState extends State<CountBody> {
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
