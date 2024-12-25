import 'package:flutter/material.dart';
import 'package:mrasim_challenge/app/view/home_view.dart';
import 'package:mrasim_challenge/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Product App',
          theme: themeProvider.currentTheme,
          home: const HomeView(),
        );
      },
    );
  }
}
