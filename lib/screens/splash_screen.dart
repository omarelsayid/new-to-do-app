import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:to_do_sqflite/screens/home.dart';
import 'package:to_do_sqflite/shared_prefrence.dart';

class SplashScreen extends StatefulWidget {
  final String userName;

  const SplashScreen({Key? key, required this.userName}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.yellow[300]!,
      splash: Expanded(
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: SharedPreferencesHelper.getUserName(),
              builder: (context, snapshot) {
                final savedUserName = snapshot.data;
                final displayUserName = savedUserName ?? widget.userName;
                return Text(
                  'Welcome, $displayUserName',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                )
                    .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true))
                    .fadeOut(curve: Curves.easeInOut);
              },
            ),
          ],
        ),
      ),
      nextScreen: Home(),
      splashTransition: SplashTransition.sizeTransition,
      curve: Curves.easeInOutCirc,
    );
  }
}
