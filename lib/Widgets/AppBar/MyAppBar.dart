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
      backgroundColor: Colors.orange.shade100, // cor mais suave
      foregroundColor: Colors.black87,
      elevation: 2, // visual mais leve
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: PopupMenuButton<String>(
            icon: const Icon(Icons.menu, color: Colors.black87),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (_) {},
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'Home',
                    onTap: () => onItemSelected(0),
                    child: Row(
                      children: const [
                        Icon(Icons.home, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text('Início'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Feedback',
                    onTap: () => onItemSelected(1),
                    child: Row(
                      children: const [
                        Icon(Icons.star, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text('Avaliação'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Profile',
                    onTap: () => onItemSelected(2),
                    child: Row(
                      children: const [
                        Icon(Icons.person, color: Colors.deepOrange),
                        SizedBox(width: 8),
                        Text('Perfil'),
                      ],
                    ),
                  ),
                ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
