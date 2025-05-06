import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function(int) onItemSelected;

  const MyAppBar({
    super.key,
    required this.title,
    required this.onItemSelected,
  });

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
                    onItemSelected(0);
                  },
                ),
                PopupMenuItem<String>(
                  value: 'Feedback',
                  child: Row(children: [Icon(Icons.star), Text(' Avaliação')]),
                  onTap: () {
                    onItemSelected(1);
                  },
                ),
                PopupMenuItem<String>(
                  value: 'Profile',
                  child: Row(children: [Icon(Icons.person), Text(' Perfil')]),
                  onTap: () {
                    onItemSelected(2);
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
