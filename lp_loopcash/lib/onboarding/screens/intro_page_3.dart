import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          // animations
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(
                "lib/assets/2.json",
                repeat: true,
                width: 500,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // text
              Padding(
                padding: const EdgeInsets.only(top: 55, bottom: 25, left:25, right: 25),
                child: Text(
                  "save_money_title".tr(),
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Text(
                  "save_money_detail".tr(),
                  style: GoogleFonts.dmSerifDisplay(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}