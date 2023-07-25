import 'package:flutter/material.dart';
import 'package:flutter_api_resource/fetching_page.dart';
import 'package:flutter_api_resource/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      routes: {
        '/fetching': (context) => const FetchingPage(),
      },
    );
  }
}
