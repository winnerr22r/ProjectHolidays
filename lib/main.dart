import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/favorites_provider.dart';
import 'models/destination.dart';
import 'utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoritesProvider>(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'ProjectHolidays',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const MainNavigationScreen(),
          '/detail': (context) {
            final destination =
                ModalRoute.of(context)?.settings.arguments as Destination?;
            if (destination != null) {
              return DetailScreen(destination: destination);
            }
            return const MainNavigationScreen();
          },
        },
      ),
    );
  }
}
