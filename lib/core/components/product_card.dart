import 'package:flutter/material.dart';
import 'package:mrasim_challenge/app/model/products_model.dart';
import 'package:mrasim_challenge/core/constants/color_constants.dart';
import 'package:mrasim_challenge/core/constants/decorations.dart';
import 'package:mrasim_challenge/core/constants/icon_constants.dart';
import 'package:mrasim_challenge/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    final theme = Theme.of(context);

    final shadowColor =
        isDarkMode ? ColorConstants.shadowColorDark : ColorConstants.shadowColorLight;

    return Padding(
      padding: Insets.symmetricPadding,
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: Borders.smallBorderRadius,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: isDarkMode ? 20 : 10,
              offset: const Offset(0, 5),
              spreadRadius: isDarkMode ? 2 : 0,
            ),
          ],
        ),
        child: Row(
          children: [
            _buildProductImage(context),
            Expanded(
              child: Padding(
                padding: Insets.mediumPadding,
                child: _buildProductDetails(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Hero(
      tag: 'product-${product.id}',
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(Sizes.mediumSize),
        ),
        child: Image.network(
          product.imageUrl,
          width: LogoConstants.logoHeight,
          height: LogoConstants.logoWidth,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) =>
              _loadingBuilder(context, child, loadingProgress),
          errorBuilder: (context, error, stackTrace) => _errorBuilder(context, error, stackTrace),
        ),
      ),
    );
  }

  Widget _loadingBuilder(BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final loadingColor = isDarkMode
        ? ColorConstants.darkModeLoadingBackground
        : ColorConstants.loadingBackgroundColor;

    if (loadingProgress == null) return child;
    return Container(
      width: LogoConstants.logoHeight,
      height: LogoConstants.logoWidth,
      color: loadingColor,
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
          color: isDarkMode
              ? ColorConstants.darkModeProgressIndicator
              : Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _errorBuilder(BuildContext context, Object error, StackTrace? stackTrace) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final errorBackgroundColor =
        isDarkMode ? ColorConstants.darkModeErrorBackground : ColorConstants.loadingBackgroundColor;
    final iconColor =
        isDarkMode ? ColorConstants.darkModeIconColor : IconConstants.imageErrorIcon.color;
    final textColor =
        isDarkMode ? ColorConstants.darkModeErrorTextColor : ColorConstants.errorTextColor;

    return Container(
      width: LogoConstants.logoHeight,
      height: LogoConstants.logoWidth,
      color: errorBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: Sizes.largeSize,
            color: iconColor,
          ),
          Padding(
            padding: Insets.smallPadding,
            child: Text(
              'Image Error',
              style: TextStyles.bodyText2.copyWith(
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name.toUpperCase(),
          style: TextStyles.heading2.copyWith(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Sizes.smallSize),
        Text(
          '${product.price} SR',
          style: TextStyles.bodyText1.copyWith(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
