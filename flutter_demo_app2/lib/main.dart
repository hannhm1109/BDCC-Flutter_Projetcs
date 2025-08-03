import 'package:flutter/material.dart';
import 'global/global.parameters.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: GlobalParameters.routes,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal.shade600,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade700,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal.shade600,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          shadowColor: Colors.teal.shade100,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 22, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
          headlineLarge: TextStyle(
              fontSize: 28,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ),
          headlineMedium: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.w600
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.teal.shade600, width: 2),
          ),
          labelStyle: TextStyle(color: Colors.teal.shade700),
        ),
      ),
    );
  }
}
