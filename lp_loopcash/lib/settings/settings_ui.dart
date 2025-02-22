import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'language_page.dart';

class SettingsUi extends StatefulWidget {
  final bool showBack;
  const SettingsUi({
    super.key,
    required this.showBack,
  });

  @override
  State<SettingsUi> createState() => _SettingsUiState();
}

class _SettingsUiState extends State<SettingsUi> {
  /*// logout method
  void logout() async {
    // get auth service
    final authService = AuthService();

    // sign out 
    await authService.logout();
  }

  // user
  final user = FirebaseAuth.instance.currentUser!;
  */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      /*appBar: AppBar(
        title: Center(
          child: Text(
            user.email!,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: logout, 
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
      ),*/
      appBar: AppBar(
        automaticallyImplyLeading: widget.showBack,
        title: Center(
          child: Text("Settings"),
        ),
      ),

      body: Column(    
        children: [
          const SizedBox(height: 50,),
          // picture
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: const Icon(
              Icons.person,
              size: 200,
            ),
          ),

          // sized box
          const SizedBox(height: 30,),

          // dark mode
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(top: 20, right: 25, left: 25),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // dark mode text
                Text("dark_mode".tr()),

                // switch
                Switch(
                  activeColor: Colors.green,
                  value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, 
                  onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                ),
              ],
            ),
          ),

          // Language
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.only(top: 25, right: 25, left: 25),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // languge change 
                Text("language".tr()),
          
                // go to language page
                IconButton(
                  onPressed: () {
                    Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LanguagePage(),
                    ),
                  );
                  }, 
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}