import 'package:flutter/material.dart';

class NavigationService {
  static NavigationService? _instance;

  NavigationService._internal();

  factory NavigationService() {
    return _instance ??= NavigationService._internal();
  }

  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>(debugLabel: 'navigationKey');

  Future<dynamic>? pushNamed({required String routeName, dynamic arguments}) {
    if (isSameRoute(routeName: routeName)) {
      return navigationKey.currentState?.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    } else {
      return navigationKey.currentState?.pushNamed(
        routeName,
        arguments: arguments,
      );
    }
  }

  Future<dynamic>? pushReplacementNamed({required String routeName, dynamic arguments}) =>
      navigationKey.currentState?.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic>? pushNamedAndRemoveUntil({required String routeName, dynamic arguments}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
      arguments: arguments,
    );
  }

  Future<dynamic>? pushNamedAndRemoveUntilPredicate(
      {required String routeName, required String predicateRoute, dynamic arguments}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(predicateRoute),
      arguments: arguments,
    );
  }

  bool isSameRoute({required String routeName}) {
    bool isSameRoute = false;
    navigationKey.currentState?.popUntil((route) {
      if (route.settings.name == routeName) {
        isSameRoute = true;
      } else {
        isSameRoute = false;
      }
      return true;
    });
    return isSameRoute;
  }

  pop({dynamic result}) => navigationKey.currentState?.pop(result);

  popUntil({required RoutePredicate predicate}) => navigationKey.currentState?.popUntil(predicate);
}
