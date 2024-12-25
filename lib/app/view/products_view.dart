import 'package:flutter/material.dart';
import 'package:mrasim_challenge/app/controller/products_controller.dart';
import 'package:mrasim_challenge/core/constants/decorations.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = ProductsController();
  final _nameController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await _controller.createProduct(
      _nameController.text,
      _imageUrlController.text,
      double.parse(_priceController.text),
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product saved successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Product')),
      body: Padding(
        padding: Insets.mediumPadding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_controller.validateName(value) ? 'Name must be at least 3 characters' : null,
              ),
              const SizedBox(height: Sizes.mediumSize),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_controller.validateUrl(value) ? 'Please enter a valid URL' : null,
              ),
              const SizedBox(height: Sizes.mediumSize),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Price (SR)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    !_controller.validatePrice(value) ? 'Please enter a valid price' : null,
              ),
              const SizedBox(height: Sizes.mediumSize),
              ElevatedButton(
                onPressed: _saveProduct,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(Sizes.buttonWidth, Sizes.buttonHeight),
                ),
                child: const Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
