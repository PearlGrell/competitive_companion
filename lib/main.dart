import 'package:cp_api/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CpApi());
}

class CpApi extends StatelessWidget {
  const CpApi({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CP API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}