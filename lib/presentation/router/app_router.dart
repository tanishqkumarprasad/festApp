import 'package:fest_app/presentation/screens/about_us/about_us_page.dart';
import 'package:flutter/material.dart';
import '../screens/auth/loginpage.dart';
import '../screens/auth/roleselection.dart';
import '../screens/auth/signuppage.dart';
import '../screens/home/admin_home_screen.dart';
import '../screens/home/homescreen.dart';
import '../screens/student/upcoming_events_page.dart';
import '../screens/splash/splash_screen.dart';
import 'auth_guard.dart';

class AppRouter {
  static const String splash = '/';
  static const String choice = '/choice';
  static const String roleSelection = choice;
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String adminHome = '/admin/home';
  static const String upcomingEvents = '/upcoming-events';
  static const String aboutUs = '/about-us';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionPage());
      case login:
        final args = settings.arguments as Map<String, dynamic>?;
        final role = args?['role'] as String? ?? 'student';
        return MaterialPageRoute(builder: (_) => LoginPage(userRole: role));
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case home:
        return MaterialPageRoute(
          builder: (_) => AuthGuard(
            requiredRole: 'student',
            child: const StudentHomeScreen(),
          ),
        );
      case adminHome:
        return MaterialPageRoute(
          builder: (_) =>
              const AuthGuard(requiredRole: 'admin', child: AdminHomeScreen()),
        );
      case upcomingEvents:
        return MaterialPageRoute(builder: (_) => const UpcomingEventsPage());
      case aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  // --- RESTORED NAVIGATION HELPERS ---

  static void navigateToChoice(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(roleSelection, (route) => false);
  }

  static void navigateToRoleSelection(BuildContext context) {
    navigateToChoice(context);
  }

  static void navigateToLogin(BuildContext context, String role) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      login,
      (route) => false,
      arguments: {'role': role},
    );
  }

  static void navigateToSignup(BuildContext context) {
    Navigator.of(context).pushNamed(signup);
  }

  static void navigateToHome(BuildContext context, String role) {
    if (role == 'admin') {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(adminHome, (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        home,
        (route) => false,
        arguments: {'role': 'student'},
      );
    }
  }

  static void navigateToUpcomingEvents(BuildContext context) {
    Navigator.of(context).pushNamed(upcomingEvents);
  }

  static void navigateToAboutUs(BuildContext context) {
    Navigator.of(context).pushNamed(aboutUs);
  }
}
