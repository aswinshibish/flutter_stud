// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:take45/event.dart';

//  // Import your app file here.

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(TodoListApp());
// }


// import 'package:scoreboardapp/addevents.dart';
// import 'package:scoreboardapp/addstudents.dart';
// import 'package:scoreboardapp/event.dart';
// import 'package:scoreboardapp/home.dart';


// import 'package:scoreboardapp/mentor_login.dart';
// import 'package:scoreboardapp/mentorscreen.dart';
// import 'package:scoreboardapp/splashscreen.dart';
// import 'package:scoreboardapp/updatestd.dart';

// helllo1234
// import 'package:flutter/material.dart';



// import 'package:firebase_core/firebase_core.dart';
// import 'package:take45/addevents.dart';
// import 'package:take45/addstu.dart';
// import 'package:take45/event.dart';
// import 'package:take45/home.dart';
// import 'package:take45/mentlog.dart';
// import 'package:take45/mentscrn.dart';
// import 'package:take45/rank.dart';
// import 'package:take45/settings.dart';
// import 'package:take45/splash.dart';
// import 'package:take45/updstu.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const scoreapp());
// }

// class scoreapp extends StatelessWidget {
//   const scoreapp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/': (context) => const HomeScreen(),
//         '/splash': (context) => SplashScreen(
//               onThemeModeChanged: (ThemeMode mode) {},
//             ),
//         '/add': (context) => const AddStudentScreen(),
//         '/login': (context) => const LoginScreen(),
//         '/mentorview': (context) => const Mentor_View(),
//         '/update': (context) => const updatestd(),
//         '/events': (context) => const Events_Screen(),
//         '/addevent': (context) => const AddEventScreen(),
//         '/rank': (context) => const RankScreen(), 
//         // (context, "Settings", '/settings',// Add Rank route
//         '/settings': (context) => const SettingsPage()
//       },
//       initialRoute: '/splash',
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:take45/addevents.dart';
import 'package:take45/addstu.dart';
import 'package:take45/event.dart';
import 'package:take45/home.dart';
import 'package:take45/mentlog.dart';
import 'package:take45/mentscrn.dart';
import 'package:take45/rank.dart';
import 'package:take45/settings.dart';
import 'package:take45/splash.dart';
import 'package:take45/updstu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ScoreApp());
}

class ScoreApp extends StatefulWidget {
  const ScoreApp({super.key});

  @override
  State<ScoreApp> createState() => _ScoreAppState();
}

class _ScoreAppState extends State<ScoreApp> {
  ThemeMode _themeMode = ThemeMode.light;  // Default theme is light

  // Function to toggle theme
  void toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,  // Use the selected theme mode
      routes: {
        '/': (context) => const HomeScreen(),
        '/splash': (context) => SplashScreen(
              onThemeModeChanged: (ThemeMode mode) {
                toggleTheme(mode == ThemeMode.dark);
              },
            ),
        '/add': (context) => const AddStudentScreen(),
        '/login': (context) => const LoginScreen(),
        '/mentorview': (context) => const Mentor_View(),
        '/update': (context) => const updatestd(),
        '/events': (context) => const Events_Screen(),
        '/addevent': (context) => const AddEventScreen(),
        '/rank': (context) => const RankScreen(),
        '/settings': (context) => SettingsPage(
              onThemeToggle: toggleTheme,  // Pass theme toggle function to SettingsPage
            ),
      },
      initialRoute: '/splash',
    );
  }
}
