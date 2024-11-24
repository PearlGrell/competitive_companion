
import 'package:cp_api/screens/home_screen.dart';
import 'package:cp_api/themes/text_theme.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const CpApi());
}

class CpApi extends StatelessWidget {
  const CpApi({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, 'Poppins', "ABeeZee");
    return MaterialApp(
      title: 'CP API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        textTheme: textTheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}