import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;
  final bool showBackground;

  const FavoriteIconButton({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    this.showBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : (showBackground ? Colors.white : Colors.grey),
    );

    if (!showBackground) {
      return IconButton(
        icon: iconWidget,
        onPressed: onPressed,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.grey[700],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

