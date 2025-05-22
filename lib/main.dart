import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/ListUserRepositorie.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'Widgets/AppBar/MyAppBar.dart';
import 'Widgets/AppBody/CountBody.dart';
import 'Widgets/AppBody/ProfileBody.dart';

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
  ListUserRepositorie rep = ListUserRepositorie();
  late User user = rep.baseUser;

  MyPageState() {
    user = rep.baseUser;
  }

  void alterUser(int userId) {
    setState(() {
      user = rep.getById(userId);
    });
  }

  Widget getBody() {
    switch (selectedPage) {
      case 0:
        return CountBody();
      case 1:
        return CountBody();
      case 2:
        return ProfileBody(alterUser: alterUser, user: user);
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        onItemSelected: onAppBarItemSelected,
      ),
      body: Center(
        widthFactor: screenWidth * 0.8,
        heightFactor: screenWidth * 0.8,
        child: getBody(),
      ),
    );
  }
}
