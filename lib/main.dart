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
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
