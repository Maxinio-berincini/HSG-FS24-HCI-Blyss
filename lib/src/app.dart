import 'package:blyss/src/camera/ar_view.dart';
import 'package:blyss/src/camera/scanner_view.dart';
import 'package:blyss/src/cart/cart_view.dart';
import 'package:blyss/src/catalog/product_main_view.dart';
import 'package:blyss/src/catalog/products_overview.dart';
import 'package:blyss/src/getting_started/getting_started_view.dart';
import 'package:blyss/src/helper/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'cart/cart_model.dart';
import 'catalog/product.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = GettingStartedView.routeName;

  @override
  void initState() {
    super.initState();
    _loadInitialRoute();
  }

  Future<void> _loadInitialRoute() async {
    // Check if the user has already completed the onboarding
    final hasCompletedOnboarding =
        await widget.settingsController.loadOnboardingComplete();
    setState(() {
      // If they have, set the initial route to the product overview
      initialRoute = hasCompletedOnboarding
          ? ProductsOverviewPage.routeName
          : GettingStartedView.routeName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return ChangeNotifierProvider(
          create: (context) => CartModel()..loadCartFromPreferences(),
          child: MaterialApp(
              restorationScopeId: 'app',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
              ],
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.black,
                    shadowColor: Colors.transparent,
                    fixedSize: const Size(200, 50),
                    textStyle: const TextStyle(
                      color: ColorStyle.white,
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(color: ColorStyle.black),
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: ColorStyle.black),
                ),
                listTileTheme: const ListTileThemeData(
                  iconColor: ColorStyle.black,
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: ColorStyle.accentGrey,
                  cursorColor: ColorStyle.accentGrey,
                  selectionColor: ColorStyle.accentGreyLight,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorStyle.accentGrey),
                  ),
                ),
                switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.all(ColorStyle.accentGrey),
                  trackColor: MaterialStateProperty.all(ColorStyle.accentGreyLight),
                ),
              ),
              darkTheme: ThemeData.dark().copyWith(
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.white,
                    shadowColor: Colors.transparent,
                    fixedSize: const Size(200, 50),
                    textStyle: const TextStyle(
                      color: ColorStyle.black,
                    ),
                  ),
                ),
                iconTheme: const IconThemeData(color: ColorStyle.white),
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: ColorStyle.white),
                ),
                listTileTheme: const ListTileThemeData(
                  iconColor: ColorStyle.white,
                ),
                textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: ColorStyle.accentGreyLight,
                  cursorColor: ColorStyle.accentGreyLight,
                  selectionColor: ColorStyle.accentGrey,
                ),
                inputDecorationTheme: const InputDecorationTheme(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorStyle.accentGreyLight),
                  ),
                ),
                switchTheme: SwitchThemeData(
                  thumbColor: MaterialStateProperty.all(ColorStyle.accentGreyLight),
                  trackColor: MaterialStateProperty.all(ColorStyle.accentGrey),
                ),
              ),
              themeMode: widget.settingsController.themeMode,

              // Set the initial route based on the user's onboarding status
              initialRoute: initialRoute,
              routes: {
                GettingStartedView.routeName: (context) =>
                    GettingStartedView(controller: widget.settingsController),
                ProductsOverviewPage.routeName: (context) =>
                    const ProductsOverviewPage(),
                ProductPage.routeName: (context) => ProductPage(
                      product:
                          ModalRoute.of(context)!.settings.arguments as Product,
                    ),
                CartPage.routeName: (context) => const CartPage(),
                SettingsView.routeName: (context) =>
                    SettingsView(controller: widget.settingsController),
                QRScanner.routeName: (context) => const QRScanner(),
                ARModelViewer.routeName: (context) => ARModelViewer(
                    product:
                        ModalRoute.of(context)!.settings.arguments as Product),
              }),
        );
      },
    );
  }
}
