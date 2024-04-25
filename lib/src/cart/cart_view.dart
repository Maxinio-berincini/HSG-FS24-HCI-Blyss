import 'package:blyss/src/helper/blyssIcons_icons.dart';
import 'package:blyss/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../catalog/product.dart';
import '../helper/colors.dart';
import '../helper/text_styles.dart';
import 'cart_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const routeName = '/cart';

  double _calculateTotal(Map<int, int> items) {
    double total = 0.0;
    items.forEach((productId, quantity) {
      final product = Product.getProductById(productId);
      total += product.price * quantity;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);
    final items = cartModel.items;
    final total = _calculateTotal(items);
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Blyss', style: Style().mainHeaderFont)),
        leading: IconButton(
          icon: const Icon(
            BlyssIcons.xmark,
            size: 16,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: const Icon(BlyssIcons.gearshape2),
              onPressed: () {
                Navigator.pushNamed(context, SettingsView.routeName);
              },
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
            child: Text(
              'Your Cart Items',
              style: Style().subHeaderFont,
            ),
          ),
          if (items.isEmpty)
            Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    BlyssIcons.cart,
                    size: 100,
                    color: isDarkMode
                        ? ColorStyle.accentGreyLight
                        : ColorStyle.accentGrey,
                  ),
                  Text(
                    'Your cart is empty',
                    style: Style().infoFont.copyWith(
                        color: isDarkMode
                            ? ColorStyle.accentGreyLight
                            : ColorStyle.accentGrey),
                  ),
                ],
              ),
            ))
          else
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  int productId = items.keys.elementAt(index);
                  int quantity = items.values.elementAt(index);
                  Product product = Product.getProductById(productId);

                  return CartItem(
                    key: ValueKey(productId),
                    product: product,
                    quantity: quantity,
                    onRemove: () {
                      cartModel.removeItem(productId);
                    },
                    onQuantityChanged: (newQuantity) {
                      cartModel.changeQuantity(productId, newQuantity);
                    },
                  );
                },
              ),
            ),
          if (items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Style().subHeaderFont,
                      ),
                      Text(
                        '${total.toStringAsFixed(2)} CHF',
                        style: Style().subHeaderFont,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      // Handle checkout action
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text('Checkout',
                        style: Style().buttonFont.copyWith(
                            color: isDarkMode ? Colors.black : Colors.white)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final Product product;
  final int quantity;
  final VoidCallback onRemove;
  final Function(int) onQuantityChanged;

  const CartItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: widget.quantity.toString());
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _updateQuantity() {
    int? newQuantity = int.tryParse(_quantityController.text);
    if (newQuantity != null && newQuantity != widget.quantity) {
      widget.onQuantityChanged(newQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(widget.product.imagePath,
            height: 100, fit: BoxFit.cover),
      ),
      title: Text(
        widget.product.title,
        style: Style().cartProductTitleFont,
      ),
      subtitle: Text('${widget.product.price} CHF',
          style: Style().cartProductPriceFont),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 50,
            height: 30,
            child: TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
              onSubmitted: (value) {
                _updateQuantity();
              },
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: false),
            ),
          ),
          IconButton(
            icon: const Icon(BlyssIcons.trash),
            onPressed: widget.onRemove,
          ),
        ],
      ),
    );
  }
}
