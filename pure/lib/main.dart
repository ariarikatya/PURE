import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pure/screens/chats_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF2D2D2D),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const PureApp());
}

class PureApp extends StatelessWidget {
  const PureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PURE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Ubuntu',
      ),
      home: const ChatsScreen(),
    );
  }
}
