import 'package:flutter/material.dart';
import 'package:mobile_ui/provider/event_provider.dart';
import 'package:mobile_ui/ui/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
    ChangeNotifierProvider( 
      create: (context) =>EventProvider() ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Calendar App",
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 85, 16, 12))
        ),
        home: MainPage(),
      )
    );
  
}


