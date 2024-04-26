import 'package:blyss/src/catalog/product_main_view.dart';
import 'package:blyss/src/helper/blyssIcons_icons.dart';
import 'package:blyss/src/helper/colors.dart';
import 'package:blyss/src/helper/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_model.dart';
import '../helper/blyss_app_bar.dart';
import 'product.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  static const routeName = '/product-overview';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BlyssAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: Style().subHeaderFont,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = products[index];
                return ProductItem(product: product);
              },
              childCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key? key, required this.product}) : super(key: key);

  Widget _buildStars(double rating, bool isDarkMode) {
    List<Widget> stars = [];
    for (int i = 1; i <= rating; i++) {
      stars.add(Icon(BlyssIcons.star_filled,
          color: isDarkMode ? ColorStyle.white : ColorStyle.black));
    }
    if (rating > stars.length) {
      stars.add(Icon(BlyssIcons.star_halffilled,
          color: isDarkMode ? ColorStyle.white : ColorStyle.black));
    }
    while (stars.length < 5) {
      stars.add(Icon(BlyssIcons.star_empty,
          color: isDarkMode ? ColorStyle.white : ColorStyle.black));
    }
    return Row(children: stars);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductPage.routeName,
          arguments: product,
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imagePath,
                width: 100,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: Style().productTitleFont,
                    ),
                    Text(product.category,
                        style: Style().productCategoryFont.copyWith(
                            color: isDarkMode
                                ? ColorStyle.accentGreyLight
                                : ColorStyle.accentGrey)),
                    const SizedBox(height: 4),
                    Text(
                      product.shortDescription,
                      style: Style().productShortDescriptionFont.copyWith(
                          color: isDarkMode
                              ? ColorStyle.accentGreyLight
                              : ColorStyle.accentGrey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text('${product.price} CHF',
                        style: Style().productPriceFont),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStars(product.rating, isDarkMode),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(BlyssIcons.product_link)),
                            IconButton(
                                onPressed: () {
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItem(product.id);
                                },
                                icon: const Icon(BlyssIcons.cart)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Icons and actions can be added here
          ],
        ),
      ),
    );
  }
}
