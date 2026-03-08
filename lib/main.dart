import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/auth/auth_bloc.dart';
import 'logic/bloc/auth/auth_event.dart';

import 'logic/bloc/event/event_bloc.dart';
import 'logic/bloc/event/event_event.dart';

import 'logic/bloc/notice/notice_bloc.dart';
import 'logic/bloc/notice/notice_event.dart';

import 'logic/bloc/admin/admin_bloc.dart';

import 'logic/bloc/coordinator/coordinator_bloc.dart';
import 'logic/bloc/coordinator/coordinator_event.dart';

import 'logic/cubit/theme_cubit.dart';

import 'core/router/app_router.dart';
import 'data/services/cloudinary_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(const AppStarted()),
        ),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
        BlocProvider<EventBloc>(
          create: (_) =>
              EventBloc(useRepository: false)..add(const FetchEvents()),
        ),
        BlocProvider<NoticeBloc>(
          create: (_) =>
              NoticeBloc(useRepository: true)..add(const FetchNotices()),
        ),
        BlocProvider<AdminBloc>(
          create: (_) => AdminBloc(cloudinaryService: CloudinaryService()),
        ),
        BlocProvider<CoordinatorBloc>(
          create: (_) =>
              CoordinatorBloc(useRepository: true)
                ..add(const FetchCoordinators()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'Fest App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xFFE53935),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(),
            themeMode: mode,
            initialRoute: AppRouter.splash,
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
