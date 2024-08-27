import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_ex/globals/app_colors.dart';
import 'package:todo_ex/screens/home_screen.dart';
import 'package:todo_ex/services/setup.dart';

Future<void> main() async {
  // initialize
  WidgetsFlutterBinding.ensureInitialized();
  
  // initialize storage
  await GetStorage.init();
  
  // initialize service locator
  setup();
  
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 1,
        animationDuration: const Duration(seconds: 2),
        backgroundColor: mainColor,
        centered: true,
        splash: Text("Task Tracker", style: GoogleFonts.signikaNegative(color: Colors.white, fontSize: 50, fontWeight: FontWeight.w700)),
        nextScreen: const HomeScreen(),
      ),
    );
  }
}