import 'package:flutter/material.dart';
import 'package:hgv2/home.dart';

void main() {
  runApp(const HGV2());
}

class HGV2 extends StatelessWidget {
  const HGV2({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HGv2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}