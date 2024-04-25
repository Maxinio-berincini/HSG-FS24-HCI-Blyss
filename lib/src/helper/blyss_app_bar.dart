import 'package:blyss/src/cart/cart_view.dart';
import 'package:blyss/src/helper/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../camera/scanner_view.dart';
import '../cart/cart_model.dart';
import 'blyssIcons_icons.dart';
import 'colors.dart';

class BlyssAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlyssAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cartItemCount = context.watch<CartModel>().totalItems;
    return AppBar(
      title: Center(child: Text('Blyss', style: Style().mainHeaderFont)),
      leading: IconButton(
        icon: const Icon(BlyssIcons.camera),
        onPressed: () {
          Navigator.pushNamed(
            context,
              QRScanner.routeName,
          );

        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: badges.Badge(
            position: badges.BadgePosition.topEnd(top: 0, end: 3),
            badgeAnimation: const badges.BadgeAnimation.rotation(
                 //disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
                 curve: Curves.easeInCubic,
                ),
            showBadge: cartItemCount > 0,
            badgeStyle: const badges.BadgeStyle(
              badgeColor: ColorStyle.accentRed,
             // padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            ),
            badgeContent:
                Text('$cartItemCount', style: const TextStyle(color: ColorStyle.white)),
            child: IconButton(icon: const Icon(BlyssIcons.cart), onPressed: () {
              Navigator.pushNamed(
                context,
                CartPage.routeName,
              );
            }),
          ),
        ),
      ],
      elevation: 0,
      scrolledUnderElevation: 0,

    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
