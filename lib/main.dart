import 'package:flutter/material.dart';
import 'dependency_injection.dart';
import 'presentation/view/home_page.dart';

void main() {
  initInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Flutter Pagination'),
    );
  }
}
