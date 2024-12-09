import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:qr_app/ui/home_screen.dart';
import 'package:qr_app/ui/qr_generator_screen.dart';
import 'package:qr_app/ui/qr_scanner_screen.dart';
import 'package:qr_app/ui/splash_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Aktifkan hanya di mode debug
      builder: (context) => const MainApp(), // Wrap your app
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, // Agar device preview bekerja dengan benar
      locale: DevicePreview.locale(context), // Set locale untuk device preview
      builder:
          DevicePreview.appBuilder, // Menerapkan builder dari device preview
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/create': (context) => const QrGeneratorScreen(),
        '/scan': (context) => const QrScannerScreen(),
      },
    );
  }
}
