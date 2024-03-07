import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/constants/app_colors.dart';
import 'package:ninjaz/common/constants/asset_paths.dart';
import 'package:ninjaz/common/router/app_routes.dart';
import 'package:ninjaz/common/router/navigation_service.dart';
import 'package:ninjaz/features/auth/application/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (!state.isSplashLoading) {
          NavigationService().pushReplacementNamed(routeName: AppRoutes.dashboardScreen);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: AppColors.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Image.asset(
                AssetPaths.imgLogo,
                height: 100,
              ),
              const Spacer(flex: 2),
              const CupertinoActivityIndicator(color: AppColors.secondaryColor),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
