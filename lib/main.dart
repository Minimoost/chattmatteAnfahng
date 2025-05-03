import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/start_screen/start_screen.dart';
import 'models/character.dart';
import 'models/message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatHistory()),
      ],
      child: MaterialApp(
        title: 'ChatMate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
        ),
        home: const StartScreen(),
      ),
    );
  }
}
