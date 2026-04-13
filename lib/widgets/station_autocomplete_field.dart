import 'package:flutter/material.dart';

import '../data/mumbai_suburban_stations.dart';
import '../theme/fyp_colors.dart';

/// Single-line station search with overlay suggestions (reference UI).
class StationAutocompleteField extends StatelessWidget {
  const StationAutocompleteField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.fieldBorder,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final OutlineInputBorder fieldBorder;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      textEditingController: controller,
      focusNode: focusNode,
      displayStringForOption: (option) => option,
      optionsBuilder: (value) {
        return MumbaiSuburbanStations.matching(value.text);
      },
      onSelected: (selection) {
        onChanged(selection);
      },
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        return TextField(
          controller: textController,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: (_) => onFieldSubmitted(),
          style: const TextStyle(color: FypColors.black),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: FypColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: fieldBorder,
            focusedBorder: fieldBorder,
            border: fieldBorder,
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        final list = options.toList();
        if (list.isEmpty) return const SizedBox.shrink();

        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 6,
            color: FypColors.white,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 220),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final option = list[index];
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(
                          color: FypColors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
