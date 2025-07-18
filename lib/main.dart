import 'package:flutter/material.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/AvaliationPage/AvaliationBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/HomePage/HomeBody.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Repository/UserRepository.dart';
import 'package:flutter_pizza_delivery/Widgets/AppBody/Mock/User.dart';
import 'Widgets/AppBar/MyAppBar.dart';
import 'Widgets/AppBody/ProfilePage/ProfileBody.dart';

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
  UserRepository rep = UserRepository();
  late User baseUser = rep.getBaseUser();
  late User user = baseUser;

  MyPageState() {
    user = baseUser;
  }

  void alterUser(int userId) {
    setState(() {
      user = rep.getById(userId);
    });
  }

  Widget getBody() {
    switch (selectedPage) {
      case 0:
        return HomeBody(user: user, alterPage: onAppBarItemSelected);
      case 1:
        return AvaliationBody(user: user, alterPage: onAppBarItemSelected);
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
