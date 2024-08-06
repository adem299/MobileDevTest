import 'package:flutter/material.dart';
import 'package:mobiledev_test_app/screens/second_screen.dart';
import 'package:mobiledev_test_app/widgets/background.dart';
import 'package:mobiledev_test_app/widgets/profile_image.dart';
import 'package:mobiledev_test_app/widgets/input_field.dart';
import 'package:mobiledev_test_app/widgets/action_button.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Background(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: FirstScreenContent(),
          ),
        ),
      ),
    );
  }
}

class FirstScreenContent extends StatefulWidget {
  const FirstScreenContent({super.key});

  @override
  _FirstScreenContentState createState() => _FirstScreenContentState();
}

class _FirstScreenContentState extends State<FirstScreenContent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sentenceController = TextEditingController();

  bool _isPalindrome(String sentence) {
    String cleanedSentence = sentence.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    String reversedSentence = cleanedSentence.split('').reversed.join('');
    return cleanedSentence == reversedSentence;
  }

  void _checkPalindrome() {
    String sentence = _sentenceController.text;
    bool result = _isPalindrome(sentence);
    String message = result ? 'isPalindrome' : 'not palindrome';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Palindrome Check'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ProfileImage(),
        const SizedBox(height: 51),
        InputField(
          controller: _nameController,
          hintText: 'Name',
        ),
        const SizedBox(height: 15),
        InputField(
          controller: _sentenceController,
          hintText: 'Palindrome',
        ),
        const SizedBox(height: 45),
        ActionButton(
          text: 'CHECK',
          onPressed: _checkPalindrome,
        ),
        const SizedBox(height: 15),
        ActionButton(
          text: 'NEXT',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen(currentUser: _nameController.text)),
            );
          },
        ),
      ],
    );
  }
}
