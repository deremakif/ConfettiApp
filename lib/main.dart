import 'package:confetti_app/providers/ResultListProvider.dart';
import 'package:confetti_app/routes/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runMainApp();
}

dynamic runMainApp() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ResultListProvider(),
        ),
      ],
      child: MaterialApp(
        initialRoute: await AppRoute.getInitialRoute(),
        routes: AppRoute.getRoute(),
      ),
    ),
  );
}
