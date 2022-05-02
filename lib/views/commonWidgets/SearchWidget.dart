

import 'package:flutter/material.dart';
import 'package:tfg_theme/AppColors.dart';
import 'package:tfg_theme/AppText.dart';

///Search bar. List of images whenever text associated to search bar is modified.
///Contains a search icon if text is not written. If text is not empty a cross icon is defined
///to delete all text written.
class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive =
        AppText.bodyOutstandingText.copyWith(fontSize: 18, height: 1);
    final styleHint = TextStyle(color: AppColors.color6)
        .copyWith(fontSize: 18, height: 1);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 40,
          minHeight: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: AppColors.color6),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefix: SizedBox(width: 10),
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: Icon(Icons.close, color: style.color),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : Icon(Icons.search),
            hintText: "Search",
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}