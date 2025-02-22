import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../navigation/bottom_nav.dart';
import 'screens/intro_page_1.dart';
import 'screens/intro_page_2.dart';
import 'screens/intro_page_3.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        children: [

          // PAGES
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              IntroPage1(),
              const IntroPage2(),
              const IntroPage3(),
            ],
          ),

          // DOTS
          Container(
            alignment: const Alignment(0, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // skip or nothing
                onLastPage
                ? GestureDetector(
                  onTap: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 500), 
                      curve: Curves.easeIn,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text("prevuis".tr()),
                  ),
                )
                : GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text('skip'.tr()),
                  ),
                ),

                // dots
                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3,
                ),

                // next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) {
                                return const BottomNav();
                              }
                            )
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text("login".tr()),
                        ),
                      ) 
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500), 
                            curve: Curves.easeIn,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text('next'.tr()),
                        ),
                      ),
              ],
            ),
          ),
        ],
       )
    );
  }
}