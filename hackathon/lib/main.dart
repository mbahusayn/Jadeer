import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hackathon/app/auth/screens/loading_screen.dart';
import 'package:hackathon/services/supabse_config.dart';

void main() {
  supabaseConfig();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale("ar"),
      supportedLocales: const [Locale("ar"), Locale("en")],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "IBMPlexSans",
          useMaterial3: false,
          appBarTheme:
              const AppBarTheme(backgroundColor: Colors.white, elevation: 0),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
          scaffoldBackgroundColor: Colors.white,
          dividerTheme: const DividerThemeData(thickness: 0.8)),
      home: const LoadingScreen(),
    );
  }
}
