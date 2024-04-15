import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isar_databas/Pages/settings_page.dart';
import 'package:isar_databas/components/drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(Icons.note_outlined)
          ),
          DrawerTile(
            title: 'Notes', 
            leading: const Icon(CupertinoIcons.home),
            onTap: () => Navigator.pop(context),
          ),
          DrawerTile(
            title: 'Setting', 
            leading: const Icon(CupertinoIcons.settings),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) => const Setting(),
                 ),
                );
              },
          ),
        ],
      ),
    );
  }
}