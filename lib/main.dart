import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

// Core & Services
import 'core/theme/app_theme.dart';
import 'services/cloudinary_service.dart';

// Blocs & Cubits
import 'logic/bloc/auth/auth_bloc.dart';
import 'logic/bloc/auth/auth_event.dart';
import 'logic/bloc/event/event_bloc.dart';
import 'logic/bloc/event/event_event.dart';
import 'logic/bloc/notice/notice_bloc.dart';
import 'logic/bloc/notice/notice_event.dart';
import 'logic/bloc/coordinator/coordinator_bloc.dart';
import 'logic/bloc/coordinator/coordinator_event.dart';
import 'logic/bloc/admin/admin_bloc.dart'; // Added AdminBloc import
import 'logic/cubit/theme_cubit.dart';

// Router
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load Cloudinary credentials from .env
  await dotenv.load(fileName: ".env");

  // Initialize Firebase with generated options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const FestApp());
}

class FestApp extends StatelessWidget {
  const FestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const AppStarted()),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<EventBloc>(
          create: (_) =>
          EventBloc(useRepository: false)..add(const FetchEvents()),
        ),
        BlocProvider<NoticeBloc>(
          create: (context) => NoticeBloc(
            useRepository: true,
          )..add(const FetchNotices()),
        ),
        // Providing AdminBloc globally fixes the ProviderNotFoundException
        BlocProvider<AdminBloc>(
          create: (_) => AdminBloc(
            cloudinaryService: CloudinaryService(),
          ),
        ),
        BlocProvider<CoordinatorBloc>(
          create: (_) =>
              CoordinatorBloc(useRepository: true)..add(const FetchCoordinators()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'Fest App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: ThemeData.dark(),
            themeMode: mode,
            initialRoute: AppRouter.roleSelection,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}