import 'package:authentication/providers/notes_provider.dart';
import 'package:authentication/utils/search_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchNotesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _searchedNotes = [];
  bool _isLoading = false;
  String? _error;
  String _query = "";

  List<Map<String, dynamic>> get searchedNotes => _searchedNotes;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get query => _query;

  Future<void> searchNote(BuildContext context, String value) async {
    _isLoading = true;
    _query = value;
    notifyListeners();
    try {
      List<Map<String, dynamic>> data = context.watch<NotesProvider>().notes;
      _searchedNotes = await searchCards(data, value);
    } catch (e) {
      _error = "Failed to search note $e";
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
