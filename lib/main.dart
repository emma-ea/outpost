import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outpost/styles.dart';
import 'package:window_size/window_size.dart';

void main() {
  if (Platform.isLinux) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowMinSize(const Size(800, 800));
    setWindowTitle('Outpost');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        body: Center(
          child: Text(
            'Flutter Desktop',
            style: TextStyles.h1,
          ),
        ),
      ),
    );
  }
}

