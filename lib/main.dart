import 'package:flutter/material.dart';
import 'Widgets/AppBar/MyAppBar.dart';
import 'Widgets/AppBody/CountBody.dart';

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
      home: const MyPage(title: 'Pizza Delivery'),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key, required this.title});

  final String title;

  @override
  State<MyPage> createState() => MyPageState();
}

class MyPageState extends State<MyPage> {
  int selectedPage = 0;

  Widget getBody() {
    switch (selectedPage) {
      case 0:
        print("Home");
        return CountBody();
      case 1:
        print("Feedback");
        return CountBody();
      case 2:
        print("Profile");
        return CountBody();
      default:
        return const Text('Página não encontrada');
    }
  }

  void onAppBarItemSelected(int i) {
    setState(() {
      selectedPage = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        onItemSelected: onAppBarItemSelected,
      ),
      body: Center(child: getBody()),
    );
  }
}
