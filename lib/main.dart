import 'package:easy_wheather/Pages/home_screen.dart';
import 'package:easy_wheather/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp( ChangeNotifierProvider(child: MyApp(),create: (context) => ThemeProvider(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "Easy Weather",
      theme: Provider.of<ThemeProvider>(context).getThemeData,
    );
  }
}
