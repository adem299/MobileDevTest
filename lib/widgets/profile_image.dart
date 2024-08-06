import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 116,
      width: 116,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/ic_photo.png"),
        ),
      ),
    );
  }
}
