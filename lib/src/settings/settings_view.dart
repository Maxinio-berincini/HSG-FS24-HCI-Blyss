import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../cart/cart_model.dart';
import '../getting_started/getting_started_view.dart';
import '../helper/blyssIcons_icons.dart';
import '../helper/colors.dart';
import '../helper/text_styles.dart';
import 'settings_controller.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.controller});
  final SettingsController controller;
  static const routeName = '/settings';

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {


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
                  value: widget.controller.themeMode,
                  onChanged: widget.controller.updateThemeMode,
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
          content: Text(
              'This will reset all variables. Are you sure you want to continue?',
              style: Style().dialogTextFont),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style:
                      Style().buttonFont.copyWith(color: ColorStyle.accentRed)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm',
                  style: Style().buttonFont.copyWith(
                      color: isDarkMode ? ColorStyle.white : ColorStyle.black)),
              onPressed: () {
                // Perform the reset operation
                widget.controller.resetOnboarding();
                widget.controller.resetThemeMode();
                CartModel().clearCart();
                if (kIsWeb) {
                    Navigator.popAndPushNamed(
                        context, GettingStartedView.routeName);
                }else {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                }
              },
            ),
          ],
        );
      },
    );
  }
}
