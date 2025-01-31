import 'package:authentication/constants/colors.dart';
import 'package:authentication/providers/search_notes_provider.dart';
import 'package:authentication/widgets/build_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BuildSearchedNotesGrid extends StatelessWidget {
  const BuildSearchedNotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final searchNotesProvider =
        Provider.of<SearchNotesProvider>(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: MasonryGridView.builder(
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: searchNotesProvider.searchedNotes.length,
            itemBuilder: (context, index) {
              final toDisplayItems =
                  searchNotesProvider.searchedNotes.reversed.toList();
              final item = toDisplayItems[index];
              final color = colors[index % colors.length];
              return BuildCard(
                item: item,
                color: color,
              );
            },
          ),
        ),
      ],
    );
  }
}
