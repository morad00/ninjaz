import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjaz/common/constants/app_colors.dart';
import 'package:ninjaz/features/bottom_navigation/application/bottom_navigation_bloc.dart';
import 'package:ninjaz/features/dashboard/presentation/posts_tab_screen.dart';
import 'package:ninjaz/features/dashboard/presentation/second_tab_screen.dart';
import 'package:ninjaz/features/dashboard/presentation/third_tab_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          top: true,
          child: PageView(
            controller: state.tabsController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              PostsTabScreen(),
              SecondTabScreen(),
              ThirdTabScreen(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentTabIndex,
          onTap: (tab) => BottomNavigationEvents.navigateToTab(context, tabIndex: tab),
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.greyColor,
            items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              activeIcon: Icon(Icons.list),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person),
              label: 'Tab 2',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              activeIcon: Icon(CupertinoIcons.settings),
              label: 'Tab 3 ',
            ),
          ],
        ),
      ),
    );
  }
}
