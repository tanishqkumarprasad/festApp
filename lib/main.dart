import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// These must match your file names exactly
import 'firebase_options.dart';
import 'logic/bloc/auth/auth_bloc.dart';
import 'logic/bloc/auth/auth_event.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  print("APP_DEBUG: Starting main()");
  WidgetsFlutterBinding.ensureInitialized();

  print("APP_DEBUG: Loading .env");
  try {
    await dotenv.load(fileName: ".env");
    print("APP_DEBUG: .env Loaded Successfully");
  } catch (e) {
    print("APP_DEBUG: .env Error: $e");
  }

  print("APP_DEBUG: Initializing Firebase");
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("APP_DEBUG: Firebase Success");
  } catch (e) {
    print("APP_DEBUG: Firebase Crash: $e");
  }

  runApp(const FestApp());
}

class FestApp extends StatelessWidget {
  const FestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(const AppStarted()),
      child: MaterialApp(
        title: 'Pratibimb',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFFE53935), // Matching your TATVA logo red
          useMaterial3: true,
        ),
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
