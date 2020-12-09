import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/routes_provider.dart';
import './screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RouteProviders(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple),
        home: Scaffold(
          body: MainScreen(),
        ),
      ),
    );
  }
}
