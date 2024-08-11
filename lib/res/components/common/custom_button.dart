import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onPressed;
  final String btnText;
  final bool isIcon;
  final IconData? icon;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.isIcon = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return isIcon
        ? ElevatedButton.icon(
            icon: Icon(
              icon,
              color: theme.colorScheme.onPrimary,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
            ),
            onPressed: onPressed,
            label: Text(
              btnText,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
            ),
            onPressed: onPressed,
            child: Text(
              btnText,
              style: theme.textTheme.labelLarge!.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          );
  }
}
