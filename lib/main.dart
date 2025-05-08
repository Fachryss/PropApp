import 'package:flutter/material.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MiniEduApp());
}

class MiniEduApp extends StatelessWidget {
  const MiniEduApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PropApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Set Poppins as the default font
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Poppins'),
          bodyMedium: TextStyle(fontFamily: 'Poppins'),
          displayLarge: TextStyle(fontFamily: 'Poppins'),
          displayMedium: TextStyle(fontFamily: 'Poppins'),
          displaySmall: TextStyle(fontFamily: 'Poppins'),
          headlineMedium: TextStyle(fontFamily: 'Poppins'),
          headlineSmall: TextStyle(fontFamily: 'Poppins'),
          titleLarge: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
      initialRoute: '/',
      routes: appRoutes,
      onGenerateRoute: generateRoute,
    );
  }
}
