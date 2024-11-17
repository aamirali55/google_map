import 'package:flutter/material.dart';
import 'package:google_map/app/app.locator.dart';
import 'package:google_map/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  await setupLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
