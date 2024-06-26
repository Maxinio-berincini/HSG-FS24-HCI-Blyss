import 'package:blyss/src/camera/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../cart/cart_model.dart';
import '../helper/blyssIcons_icons.dart';
import '../helper/blyss_app_bar.dart';
import '../helper/colors.dart';
import '../helper/text_styles.dart';
import 'product.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  static const routeName = '/product-view';

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late PageController pageController;
  late int initialIndex;
  double blurAmount = 0;

  @override
  void initState() {
    super.initState();
    initialIndex = Product.findProductIndexById(widget.product.id);
    if (initialIndex == -1) {
      initialIndex = 0;
    }
    pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.87,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  double getScale(double currentPage, int pageIndex) {
    var delta = (currentPage - pageIndex).abs();
    if (delta < 1.0) {
      return 1 - 0.05 * delta;
    }
    return 0.95;
  }

  double getTextScale(double currentPage, int pageIndex) {
    var delta = (currentPage - pageIndex).abs();
    if (delta < 1.0) {
      return 1 - 0.4 * delta;
    }
    return 0.6;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const BlyssAppBar(),
      body: PageView.builder(
        controller: pageController,
        itemBuilder: (context, index) {
          final realIndex = index % products.length;
          final product = products[realIndex];
          return Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                height: MediaQuery.of(context).size.height * 0.55,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (pageController.position.haveDimensions) {
                      scale = getScale(
                          pageController.page ??
                              pageController.initialPage.toDouble(),
                          index);
                    }
                    return Center(
                      child: Transform.scale(
                        scale: scale,
                        child: child,
                      ),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            product.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          icon: const Icon(
                            BlyssIcons.open_obj,
                            color: ColorStyle.black,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ARModelViewer.routeName,
                              arguments: product,
                            );
                          },
                        ),
                      ),
                      /*
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: blurAmount,
                            sigmaY: blurAmount,
                          ),
                          child: Container(color: Colors.transparent),
                        ),
                      ),

                       */
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.55,
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedBuilder(
                    animation: pageController,
                    builder: (context, child) {
                      double scale = 1.0;
                      if (pageController.position.haveDimensions) {
                        scale = getTextScale(
                            pageController.page ??
                                pageController.initialPage.toDouble(),
                            index);
                      }

                      return Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                          child: child,
                        ),
                      );
                    },
                    child: DraggableScrollableSheet(
                      initialChildSize: 1,
                      minChildSize: 1,
                      maxChildSize: 1,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.title,
                                        style: Style().mainProductTitleFont,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(BlyssIcons.product_link),
                                      onPressed: () {
                                        // TODO: Implement product link
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(BlyssIcons.cart),
                                      onPressed: () {
                                        Provider.of<CartModel>(context,
                                                listen: false)
                                            .addItem(product.id);
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  product.category,
                                  style: Style().productCategoryFont.copyWith(
                                      color: isDarkMode
                                          ? ColorStyle.accentGreyLight
                                          : ColorStyle.accentGrey),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  product.description,
                                  style: Style().productDescriptionFont,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
