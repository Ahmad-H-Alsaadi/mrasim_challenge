import 'package:flutter/material.dart';
import 'package:mrasim_challenge/core/constants/decorations.dart';
import 'package:mrasim_challenge/core/models/documentation_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DocumentationDialog extends StatefulWidget {
  const DocumentationDialog({super.key});

  @override
  State<DocumentationDialog> createState() => _DocumentationDialogState();
}

class _DocumentationDialogState extends State<DocumentationDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int featuresPerPage = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final features = AppDocumentation.pages.features;
    final pageCount = (features.length / featuresPerPage).ceil();

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: Borders.mediumBorderRadius,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            _buildHeader(theme),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: pageCount,
                itemBuilder: (context, index) {
                  final startIndex = index * featuresPerPage;
                  final endIndex = (startIndex + featuresPerPage <= features.length)
                      ? startIndex + featuresPerPage
                      : features.length;
                  final pageFeatures = features.sublist(startIndex, endIndex);

                  return SingleChildScrollView(
                    padding: Insets.mediumPadding,
                    child: Column(
                      children: [
                        if (index == 0) _buildWelcomeSection(theme),
                        ...pageFeatures.map((feature) => _buildFeatureCard(feature, theme)),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildFooter(theme, pageCount),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: Insets.mediumPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Text(
            'App Documentation',
            style: TextStyles.heading1.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Sizes.smallSize),
          Text(
            'Explore features and functionality',
            style: TextStyles.bodyText1.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.largeSize),
      padding: Insets.mediumPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: Borders.mediumBorderRadius,
      ),
      child: Column(
        children: [
          Icon(
            Icons.apps_rounded,
            size: Sizes.extraLargeSize,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: Sizes.mediumSize),
          Text(
            'Welcome to the Product Management System',
            style: TextStyles.heading2.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(DocFeature feature, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.mediumSize),
      decoration: Styles.containerDecoration.copyWith(
        color: theme.colorScheme.surface,
        borderRadius: Borders.mediumBorderRadius,
      ),
      child: Padding(
        padding: Insets.mediumPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: Insets.smallPadding,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: Borders.smallBorderRadius,
                  ),
                  child: Icon(
                    _getFeatureIcon(feature.title),
                    color: theme.colorScheme.primary,
                    size: Sizes.iconSize,
                  ),
                ),
                const SizedBox(width: Sizes.mediumSize),
                Expanded(
                  child: Text(
                    feature.title,
                    style: TextStyles.heading2.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Sizes.mediumSize),
            Text(
              feature.description,
              style: TextStyles.bodyText1.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, int pageCount) {
    return Container(
      padding: Insets.mediumPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              size: Sizes.iconSize,
            ),
            label: Text(
              'Close',
              style: TextStyles.buttonText.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: _pageController,
            count: pageCount,
            effect: WormEffect(
              dotColor: theme.colorScheme.onSurface.withOpacity(0.2),
              activeDotColor: theme.colorScheme.primary,
              dotHeight: Sizes.smallSize,
              dotWidth: Sizes.smallSize,
              spacing: Sizes.smallSize,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFeatureIcon(String title) {
    switch (title.toLowerCase()) {
      case 'product list management':
        return Icons.list_alt;
      case 'quick actions':
        return Icons.flash_on;
      case 'data validation':
        return Icons.check_circle;
      case 'local storage':
        return Icons.storage;
      case 'search & filter':
        return Icons.search;
      case 'theme support':
        return Icons.palette;
      default:
        return Icons.star;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
