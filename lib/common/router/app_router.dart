import 'package:flutter/material.dart';
import 'package:ninjaz/common/router/app_routes.dart';
import 'package:ninjaz/features/dashboard/presentation/dashboard_screen.dart';
import 'package:ninjaz/features/auth/presentation/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return _screen(
          settings: settings,
          screen: const SplashScreen(),
        );
      case AppRoutes.dashboardScreen:
        {
          return _screen(
            settings: settings,
            screen: const DashboardScreen(),
          );
        }
    }
    return null;
  }

  static PageTransition _screen({
    required Widget screen,
    required RouteSettings settings,
    PageTransitionType pageTransition = PageTransitionType.rightToLeft,
  }) {
    return PageTransition(
      type: pageTransition,
      duration: const Duration(milliseconds: 120),
      child: screen,
      settings: settings,
      reverseDuration: const Duration(milliseconds: 120),
      opaque: true,
    );
    // MaterialPageRoute(builder: (ctx) => screen, settings: settings);
  }
}
