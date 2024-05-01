import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/note_database.dart';
import 'Pages/note_page.dart';
import 'Theme/theme_provider.dart';

void main() async {

  // initialize note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteData.initialize();
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteData(),),
      ChangeNotifierProvider(create: (context) => ThemeProvider(),)
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const NotesPage(),
    );
  }
}
