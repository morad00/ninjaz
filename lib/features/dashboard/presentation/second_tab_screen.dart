import 'package:flutter/material.dart';
import 'package:ninjaz/common/constants/app_colors.dart';

class SecondTabScreen extends StatelessWidget {
  const SecondTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tab 2'),
      ),
      body: Center(
        child: FilledButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColors.secondaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () {},
          child: const Text('Coming Soon',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
        ),
      ),
    );
  }
}
