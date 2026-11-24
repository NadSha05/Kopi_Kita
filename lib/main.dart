import 'package:flutter/material.dart';
import 'halaman_beranda.dart';

void main() => runApp(const KopiKitaApp());

class KopiKitaApp extends StatelessWidget {
  const KopiKitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopi Kita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFAF5F0),
      ),
      home: const HalamanBeranda(),
    );
  }
}
