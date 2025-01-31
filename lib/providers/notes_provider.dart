import 'package:authentication/services/database_service.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Map<String, dynamic>> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> addNote(
      {required String title, required String description}) async {
    try {
      await _databaseService.addNote(title: title, description: description);
      await getNotes();
    } catch (e) {
      _error = "Failed to add notes $e";
      notifyListeners();
    }
  }

  Future<void> getNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _databaseService.getNotes();
      _error = null;
    } catch (e) {
      _error = "Failed to fetch notes $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> editNote({
    required int id,
    required String title,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _databaseService.editNote(
        id: id,
        title: title,
        description: description,
      );
      await getNotes();
      notifyListeners();
    } catch (e) {
      _error = "Failed to update note $e";
      notifyListeners();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> archiveNote({
    required int id,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _databaseService.archiveNote(id: id);
      await getNotes();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to archive note $e';
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }
}
