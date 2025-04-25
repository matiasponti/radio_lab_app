import 'package:flutter/material.dart';
import 'package:radio_lab_app/presentation/pages/favorites_page.dart';

class RadioHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RadioHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Radio Stations'),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FavoritesPage()),
            );
          },
        ),
      ],
    );
  }
}
