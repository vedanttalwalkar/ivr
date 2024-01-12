import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ivrapp/constants.dart';
import 'package:ivrapp/providers/prescription_provider.dart';
import 'package:ivrapp/providers/user_provider.dart';
import 'package:ivrapp/routes.dart';
import 'package:ivrapp/widgets/welcome.dart';
import 'package:provider/provider.dart';
import 'screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBZQTMD7h4lMIt8BSddik1vhXhdNziahxk",
            authDomain: "insta-clone-33281.firebaseapp.com",
            projectId: "insta-clone-33281",
            storageBucket: "insta-clone-33281.appspot.com",
            messagingSenderId: "744133681799",
            appId: "1:744133681799:web:9436a7e09c44df97ab4e22",
            measurementId: "G-QC35B9BP71"));
  }
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(foregroundColor: Colors.black),
          // iconButtonTheme: IconButtonThemeData(
          //     style: ButtonStyle(
          //         iconColor: MaterialStateProperty.all<Color>(whiteColor))),
          //iconTheme: IconThemeData().copyWith(color: whiteColor),
          appBarTheme: AppBarTheme().copyWith(color: greenColor),
          colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => getRoutes(settings),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return HomeScreen();
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              );
            }
            return WelcomeScreen();
          },
        ),
      ),
    );
  }
}
