import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({required this.title});

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
