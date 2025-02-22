import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../home/presentation/home_ui.dart';
import '../profit/profit_ui.dart';
import '../settings/settings_ui.dart';
import '../shop/presentation/shop_ui.dart';
import '../statics/statics_ui.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  // pages
  final List<Widget> _screens = [
    const HomeUi(), 
    const ShopUi(),
    const StaticsUi(),
    const ProfitUi(),
    const SettingsUi(showBack: false,),
  ];

  final List<IconData> icons = [
    Icons.home,
    Icons.shopping_cart,
    Icons.trending_up_rounded,
    Icons.analytics_outlined,
    Icons.settings
  ];

  final List<String> labels = [
    'home', 
    'shop', 
    'statics', 
    'profit', 
    'settings',
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex],
      bottomNavigationBar: ClipPath(
        clipper: BottomNavClipper(),
        child: BottomAppBar(
          elevation: 0,
          height: 100,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 13, left: 4, right: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: selectedIndex == index ? 20 : 0),
                    decoration: BoxDecoration(
                      color: selectedIndex == index ? Colors.yellow : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icons[index],
                          size: 24,
                          color: selectedIndex == index ? Colors.black : Colors.grey,
                        ),
                        if (selectedIndex == index)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              labels[index].tr(),
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper for Curved Bottom Navigation
class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double cornerRadius = 25.0;

    path.lineTo(0, cornerRadius);
    path.quadraticBezierTo(0, 0, cornerRadius, 0);
    path.lineTo(size.width - cornerRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, cornerRadius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
