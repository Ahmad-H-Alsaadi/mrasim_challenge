import 'package:flutter/material.dart';
import 'package:mrasim_challenge/app/controller/products_controller.dart';
import 'package:mrasim_challenge/app/model/products_model.dart';
import 'package:mrasim_challenge/core/components/add_product_button.dart';
import 'package:mrasim_challenge/core/components/dismissible_wrapper.dart';
import 'package:mrasim_challenge/core/components/documentation_dialog.dart';
import 'package:mrasim_challenge/core/components/product_card.dart';
import 'package:mrasim_challenge/core/constants/color_constants.dart';
import 'package:mrasim_challenge/core/constants/decorations.dart';
import 'package:mrasim_challenge/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProductsController _controller = ProductsController();
  List<ProductsModel> _products = [];
  List<ProductsModel> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  String _sortBy = 'name';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final products = await _controller.getAllProducts();
    setState(() {
      _products = products;
      _filterProducts();
    });
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product.name.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
      _sortProducts();
    });
  }

  void _sortProducts() {
    setState(() {
      switch (_sortBy) {
        case 'name':
          _filteredProducts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'price':
          _filteredProducts.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'date':
          _filteredProducts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);
    final iconColor =
        isDarkMode ? ColorConstants.darkModeIconColor : ColorConstants.lightModeIconColor;
    final secondaryIconColor =
        isDarkMode ? ColorConstants.lightModeIconColor : ColorConstants.darkModeIconColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.info_outline_rounded,
            color: iconColor,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const DocumentationDialog(),
            );
          },
        ),
        title: Center(
          child: Text(
            'Products',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: isDarkMode
                  ? ColorConstants.darkModePrimaryText
                  : ColorConstants.lightModePrimaryText,
            ),
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: iconColor,
            ),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: Insets.allPadding,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: theme.textTheme.bodyMedium,
                    prefixIcon: Icon(
                      Icons.search,
                      color: iconColor,
                    ),
                    filled: true,
                    border: const OutlineInputBorder(
                      borderRadius: Borders.smallBorderRadius,
                      borderSide: BorderSide(
                        color: ColorConstants.shadowColor,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: Borders.smallBorderRadius,
                      borderSide: BorderSide(
                        color: ColorConstants.shadowColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: Borders.smallBorderRadius,
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.mediumSize),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSortChip('Name', 'name'),
                      const SizedBox(width: Sizes.smallSize),
                      _buildSortChip('Price', 'price'),
                      const SizedBox(width: Sizes.smallSize),
                      _buildSortChip('Date', 'date'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return DismissibleWrapper(
                  itemId: product.id!,
                  onDelete: () async {
                    bool success = await _controller.deleteProduct(product.id!);
                    if (success) {
                      setState(() {
                        _products.removeWhere((p) => p.id == product.id);
                        _filterProducts();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Product deleted successfully',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.snackBarTheme.contentTextStyle?.color,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: ProductCard(product: product),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AddProductButton(
        onProductsUpdated: _loadProducts,
        iconColor: secondaryIconColor,
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final theme = Theme.of(context);
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;

    return FilterChip(
      label: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: _sortBy == value
              ? (isDarkMode ? ColorConstants.chipSelectedDark : ColorConstants.chipSelectedLight)
              : theme.textTheme.bodyMedium?.color,
        ),
      ),
      selected: _sortBy == value,
      onSelected: (bool selected) {
        setState(() {
          _sortBy = value;
          _sortProducts();
        });
      },
      backgroundColor: theme.chipTheme.backgroundColor,
      selectedColor: theme.primaryColor.withOpacity(0.2),
      checkmarkColor:
          isDarkMode ? ColorConstants.darkModeIconColor : ColorConstants.lightModeIconColor,
    );
  }
}
