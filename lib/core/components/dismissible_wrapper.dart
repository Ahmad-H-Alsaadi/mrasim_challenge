import 'package:flutter/material.dart';
import 'package:mrasim_challenge/core/constants/color_constants.dart';
import 'package:mrasim_challenge/core/constants/decorations.dart';
import 'package:mrasim_challenge/core/constants/icon_constants.dart';

class DismissibleWrapper extends StatelessWidget {
  final Widget child;
  final int itemId;
  final VoidCallback onDelete;

  const DismissibleWrapper({
    super.key,
    required this.child,
    required this.itemId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(itemId),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: const BoxDecoration(
          color: ColorConstants.deleteBackgroundColor,
          borderRadius: Borders.mediumBorderRadius,
        ),
        alignment: Alignment.centerRight,
        padding: Insets.symmetricPadding,
        child: IconConstants.deleteIcon,
      ),
      onDismissed: (_) => onDelete(),
      child: child,
    );
  }
}
