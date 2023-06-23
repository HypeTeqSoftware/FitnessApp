import 'package:fitnessapp/view/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class StartScreen extends StatelessWidget {
  static String routeName = "/StartScreen";

  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: media.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [AppColors.primaryColor1, AppColors.primaryColor2],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              "Fitness",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 36,
                color: AppColors.blackColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              "Everybody Can Train",
              style: TextStyle(
                color: Color(0xff7b6f72),
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  Navigator.pushNamed(context, OnBoardingScreen.routeName);
                },
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                textColor: AppColors.primaryColor1,
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
