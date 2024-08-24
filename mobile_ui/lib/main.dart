import 'package:flutter/material.dart';
import 'package:mobile_ui/database/database_helper.dart';
import 'package:mobile_ui/provider/event_provider.dart';
import 'package:mobile_ui/provider/mail_provider.dart';
import 'package:mobile_ui/provider/user_provider.dart';
import 'package:mobile_ui/repository/event_repository.dart';
import 'package:mobile_ui/services/auth_service.dart';
import 'package:mobile_ui/services/event_service.dart';
import 'package:mobile_ui/ui/main_page.dart';
import 'package:mobile_ui/ui/sign_in_page.dart';
import 'package:mobile_ui/ui/sign_up_page.dart';
import 'package:provider/provider.dart';

void main() async{
  // Initialize services and repositories

  final EventService eventService = EventService(); 
  final DatabaseHelper databaseHelper = DatabaseHelper();// Assume EventService is implemented\

  final EventRepository eventRepository = EventRepository(databaseHelper,eventService); // Create EventRepository with EventService
  final AuthService authService = AuthService();
  runApp( 
    MyApp(eventRepository: eventRepository,authService: authService));
}

class MyApp extends StatelessWidget {
  final EventRepository eventRepository; // EventRepository instance
  final AuthService authService;
  const MyApp({super.key, required this.eventRepository, required this.authService});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) =>
    MultiProvider( 
      providers: [ChangeNotifierProvider(create: (context) =>EventProvider(eventRepository),),
                  ChangeNotifierProvider(create: (context) =>MailProvider(),),
                  ChangeNotifierProvider(create: (context) =>UserProvider(authService))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Calendar App",
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(backgroundColor: const Color.fromARGB(255, 85, 16, 12))
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SignInPage(),
          '/sign_up': (context) =>SignUpPage(),
          '/home': (context) => MainPage(),
        },
      )
    );
  
}


