import 'package:flutter/material.dart';
import 'package:mobiledev_test_app/provider/user_provider.dart';
import 'package:mobiledev_test_app/utils/colors.dart';
import 'package:mobiledev_test_app/screens/third_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobiledev_test_app/widgets/custom_app_bar.dart';
import 'package:mobiledev_test_app/widgets/action_button.dart';

class SecondScreen extends StatelessWidget {
  final String currentUser;
  const SecondScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Second Screen'),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserGreeting(currentUser: currentUser),
            Expanded(
              child: Center(
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return Text(
                      userProvider.selectedUserName,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: textColor),
                    );
                  },
                ),
              ),
            ),
            ActionButton(
              text: 'Choose a User',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThirdScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UserGreeting extends StatelessWidget {
  final String currentUser;

  const UserGreeting({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
        ),
        Text(
          currentUser,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
