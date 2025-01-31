import 'package:authentication/constants/colors.dart';
import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/widgets/build_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class BuildArchivedNotesGrid extends StatelessWidget {
  const BuildArchivedNotesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    return Column(
      children: [
        Expanded(
          child: MasonryGridView.builder(
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              final toDisplayItems = notesProvider.notes.reversed.toList();
              final item = toDisplayItems[index];
              if (item["status"] == "archived") {
                final color = colors[index % colors.length];
                return BuildCard(
                  item: item,
                  color: color,
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}
