import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/router/app_router.dart';
import 'package:ninjaz/common/router/app_routes.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/auth/application/auth_bloc.dart';
import 'package:ninjaz/features/bottom_navigation/application/bottom_navigation_bloc.dart';
import 'package:ninjaz/features/connection_status/applicataion/connection_status_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerBuilder: () => const ClassicFooter(
        loadingText: '',
        idleText: '',
        idleIcon: null,
        canLoadingIcon: null,
        canLoadingText: '',
        failedText: '',
        noDataText: '',
        loadingIcon: CupertinoActivityIndicator(),
      ),
      springDescription: const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 0,
      enableScrollWhenRefreshCompleted: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ConnectionStatusBloc>(
            create: (context) => ConnectionStatusBloc()..add(CheckConnectionStatus()),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc()..add(AppStartedEvent()),
          ),
          BlocProvider<BottomNavigationBloc>(
            create: (context) => BottomNavigationBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Ninjaz App',
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService().navigationKey,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRoutes.splashScreen,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
        ),
      ),
    );
  }
}
