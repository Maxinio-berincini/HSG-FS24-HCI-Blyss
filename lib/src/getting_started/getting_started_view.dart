import 'package:blyss/src/catalog/products_overview.dart';
import 'package:flutter/material.dart';

import '../helper/text_styles.dart';
import '../settings/settings_controller.dart';

class GettingStartedView extends StatefulWidget {
  const GettingStartedView({Key? key, required this.controller}) : super(key: key);
  static const routeName = '/getting-started';
  final SettingsController controller;

  @override
  _GettingStartedViewState createState() => _GettingStartedViewState();
}

class _GettingStartedViewState extends State<GettingStartedView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextButtonPressed() {
    if (_currentPage < 2) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushNamed(context, ProductsOverviewPage.routeName);
      widget.controller.completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Blyss', style: Style().mainHeaderFont)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                _buildPageContent(
                    image: isDarkMode ? 'gs_screen1_w.png' : 'gs_screen1.png',
                    title: 'Welcome to Blyss \n Your Shopping Companion',
                    description:
                        'Transform the way you browse and shop with immersive AR technology.'),
                _buildPageContent(
                    image: isDarkMode ? 'gs_screen2_w.png' : 'gs_screen2.png',
                    title: 'Scan & Visualize',
                    description:
                        'Bring products to life by scanning their QR codes'),
                _buildPageContent(
                    image: isDarkMode ? 'gs_screen3_w.png' : 'gs_screen3.png',
                    title: 'Engage & Decide',
                    description:
                        'Explore and make confident purchases at your fingertips'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3, (index) => _buildDot(index: index, isDarkMode: isDarkMode)),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _onNextButtonPressed,
            child: Text(
              'Next',
              style: Style().buttonFont.copyWith(color: isDarkMode ? Colors.black : Colors.white),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDot({required int index, required bool isDarkMode}) {
    return Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isDarkMode
            ? _currentPage == index
                ? Colors.white
                : Colors.grey
            : _currentPage == index
                ? Colors.black
                : Colors.grey[300],
      ),
    );
  }

  Widget _buildPageContent(
      {required String image,
      required String title,
      required String description}) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            'assets/images/getting_started/$image',
            width: MediaQuery.of(context).size.width * 0.8,
            height: 400,
          ),
        ),
        Text(
          title,
          style: Style().welcomeTitleFont,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Style().welcomeTextFont,
          maxLines: 2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
