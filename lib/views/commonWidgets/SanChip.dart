import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

class SanChip extends StatelessWidget {
  SanChip({required this.label, this.color, this.highlight = false});

  final String label;
  final Color? color;
  final bool highlight;

  Widget build(BuildContext context) {
    return Chip(
      labelPadding: EdgeInsets.symmetric(horizontal: 4),
      avatar: highlight
          ? CircleAvatar(
              backgroundColor: Color(0x00000000),
              child: Icon(Icons.star, color: AppColors.color13),
            )
          : null,
      label: Text(
        label,
        style: AppText.bodyText.copyWith(color: AppColors.color12),
      ),
      backgroundColor: Colors.white,
      elevation: 2.0,
      shadowColor: Colors.grey[60],
    );
  }
}
