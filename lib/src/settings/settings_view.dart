import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../cart/cart_model.dart';
import '../helper/blyssIcons_icons.dart';
import '../helper/colors.dart';
import '../helper/text_styles.dart';
import 'settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(BlyssIcons.xmark, size: 16),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Theme'),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: controller.themeMode,
                  onChanged: controller.updateThemeMode,
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('System'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light'),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark'),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Reset App'),
              trailing: IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () => _showResetConfirmationDialog(context),
              ),
            ),
            const Divider(),
            // Add more settings options here
          ],
        ),
      ),
    );
  }


void _showResetConfirmationDialog(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reset App', style: Style().dialogTitleFont),
        content: Text('This will reset all variables. Are you sure you want to continue?', style: Style().dialogTextFont),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',style: Style().buttonFont.copyWith(color: ColorStyle.accentRed)),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child:  Text('Confirm', style: Style().buttonFont.copyWith(color: isDarkMode? ColorStyle.white: ColorStyle.black)),
            onPressed: () {
              // Perform the reset operation
              controller.resetOnboarding();
              controller.resetThemeMode();
              CartModel().clearCart();
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),
        ],
      );
    },
  );
}
}
