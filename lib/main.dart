import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'logic/bloc/event/event_bloc.dart';
import 'logic/bloc/event/event_event.dart';
import 'logic/bloc/theme_cubit.dart';
import 'presentation/screens/home/homescreen.dart';

void main() {
  // No Firebase initialization here so the app can run
  // without Firebase configured, useful for early UI testing.
  runApp(const FestApp());
}

class FestApp extends StatelessWidget {
  const FestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<EventBloc>(
          // For now, run without Firestore/Firebase – this uses
          // the in-memory branch in EventBloc and immediately
          // emits EventEmpty.
          create: (_) =>
              EventBloc(useRepository: false)..add(const FetchEvents()),
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
            home: const StudentHomeScreen(),
          );
        },
      ),
    );
  }
}

