import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum AppButtonVariant { primary, secondary, text, outlined }

enum AppButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonDisabled = isDisabled || isLoading || onPressed == null;

    final double? resolvedWidth = width ?? _defaultWidthForVariant();
    final double resolvedHeight = height ?? _getHeight();

    return SizedBox(
      width: resolvedWidth,
      height: resolvedHeight,
      child: _buildButton(isButtonDisabled),
    );
  }

  Widget _buildButton(bool isButtonDisabled) {
    switch (variant) {
      case AppButtonVariant.primary:
        return ElevatedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: _getPrimaryStyle(isButtonDisabled),
          child: _buildChild(),
        );
      case AppButtonVariant.secondary:
        return ElevatedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: _getSecondaryStyle(isButtonDisabled),
          child: _buildChild(),
        );
      case AppButtonVariant.text:
        return TextButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: _getTextStyle(isButtonDisabled),
          child: _buildChild(),
        );
      case AppButtonVariant.outlined:
        return OutlinedButton(
          onPressed: isButtonDisabled ? null : onPressed,
          style: _getOutlinedStyle(isButtonDisabled),
          child: _buildChild(),
        );
    }
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(_getTextColor()),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: _getIconSize(), color: _getTextColor()),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: _getFontSize(),
              fontWeight: _getFontWeight(),
              color: _getTextColor(),
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: _getFontSize(),
        fontWeight: _getFontWeight(),
        color: _getTextColor(),
      ),
    );
  }

  ButtonStyle _getPrimaryStyle(bool isButtonDisabled) {
    return ElevatedButton.styleFrom(
      backgroundColor: isButtonDisabled ? Colors.grey[400] : AppColors.primary,
      foregroundColor: Colors.white,
      elevation: isButtonDisabled ? 0 : 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getSecondaryStyle(bool isButtonDisabled) {
    return ElevatedButton.styleFrom(
      backgroundColor: isButtonDisabled ? Colors.grey[200] : Colors.white,
      foregroundColor: isButtonDisabled ? Colors.grey[500] : AppColors.primary,
      elevation: 0,
      side: BorderSide(
        color: isButtonDisabled ? Colors.grey[300]! : AppColors.primary,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      padding: _getPadding(),
    );
  }

  ButtonStyle _getTextStyle(bool isButtonDisabled) {
    return TextButton.styleFrom(
      foregroundColor: isButtonDisabled
          ? Colors.grey[500]
          : AppColors.secondary,
      padding: _getPadding(),
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  ButtonStyle _getOutlinedStyle(bool isButtonDisabled) {
    return OutlinedButton.styleFrom(
      foregroundColor: isButtonDisabled ? Colors.grey[500] : AppColors.primary,
      side: BorderSide(
        color: isButtonDisabled ? Colors.grey[300]! : AppColors.primary,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getBorderRadius()),
      ),
      padding: _getPadding(),
    );
  }

  Color _getTextColor() {
    if (isDisabled || isLoading) {
      return Colors.grey[500]!;
    }

    switch (variant) {
      case AppButtonVariant.primary:
        return Colors.white;
      case AppButtonVariant.secondary:
        return AppColors.primary;
      case AppButtonVariant.text:
        return AppColors.secondary;
      case AppButtonVariant.outlined:
        return AppColors.primary;
    }
  }

  double? _defaultWidthForVariant() {
    // Text buttons should shrink-wrap by default (better inside Rows).
    // For full-width text buttons, pass `width: double.infinity` or wrap in Expanded.
    if (variant == AppButtonVariant.text) return null;
    return double.infinity;
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 44;
      case AppButtonSize.large:
        return 52;
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 14;
      case AppButtonSize.large:
        return 16;
    }
  }

  FontWeight _getFontWeight() {
    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.secondary:
      case AppButtonVariant.outlined:
        return FontWeight.w600;
      case AppButtonVariant.text:
        return FontWeight.w500;
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return 8;
      case AppButtonSize.medium:
        return 12;
      case AppButtonSize.large:
        return 16;
    }
  }

  EdgeInsets _getPadding() {
    if (variant == AppButtonVariant.text) {
      return EdgeInsets.zero;
    }

    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }
}
