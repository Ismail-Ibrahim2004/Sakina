import 'package:flutter/material.dart';
import '../style/my_colors.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key, required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.darkBackground,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            color: MyColors.darkBackground,
            image: DecorationImage(
              image: AssetImage("assets/images/islamic_pattern.png"),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              opacity: 0.12,
            ),
          ),
          child: body,
        ),
      ),
    );
  }
}
