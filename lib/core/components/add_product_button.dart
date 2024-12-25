import 'package:flutter/material.dart';
import 'package:mrasim_challenge/app/view/products_view.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onProductsUpdated;
  final Color iconColor;

  const AddProductButton({
    super.key,
    required this.onProductsUpdated,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _navigateToProductsView(context),
      child: Icon(Icons.add, color: iconColor),
    );
  }

  Future<void> _navigateToProductsView(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductsView()),
    );
    onProductsUpdated();
  }
}
