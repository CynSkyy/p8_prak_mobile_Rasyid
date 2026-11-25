import 'package:flutter/material.dart';
import 'package:pertemuan8/setting.dart';
import 'package:pertemuan8/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeprovider, child) {
        return MaterialApp(
          title: 'Pengaturan Tema',
          debugShowCheckedModeBanner: false,
          home: const HalamanSetting(),
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: themeprovider.themeMode,
        );
      },
    );
  }
}