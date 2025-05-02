import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 165, 126, 0),
        ),
      ),
      home: const MyHomePage(title: 'Pizza Delivery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _BasePageState();
}

class _BasePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(title: widget.title),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Como avalia sua entrega?'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _AppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.list), // ícone no AppBar
          onSelected: (String value) {},
          itemBuilder:
              (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Home',
                  child: Row(children: [Icon(Icons.home), Text(' Inicio')]),
                  onTap: () {
                    print("Inicio");
                  },
                ),
                PopupMenuItem<String>(
                  value: 'Feedback',
                  child: Row(children: [Icon(Icons.star), Text(' Avaliação')]),
                  onTap: () {
                    print("Avaliação");
                  },
                ),
                PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(children: [Icon(Icons.person), Text(' Perfil')]),
                  onTap: () {
                    print("Perfil");
                  },
                ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
