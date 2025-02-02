import 'package:authentication/services/database_service.dart';
import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Map<String, dynamic>> _notes = [];
  bool _isLoading = false;
  String? _error;
  Map<String, dynamic> _singleNote = {};
  int _days = 0;

  List<Map<String, dynamic>> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic> get singleNote => _singleNote;
  int get days => _days;

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

  Future<void> getNoteById({required int id}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _singleNote = await _databaseService.getNoteById(id: id);
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

  Future<void> unArchiveNote({
    required int id,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _databaseService.unArchiveNote(id: id);
      await getNotes();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to archive note $e';
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteNote({
    required int id,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _databaseService.deleteNote(id: id);
      await getNotes();
      notifyListeners();
    } catch (e) {
      _error = 'Failed to delete note $e';
      notifyListeners();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> calculateDays({required int id}) async {
    await getNoteById(id: id);
    final note = singleNote;
    DateTime deletedDate = DateTime.parse(note["deleted_at"]);
    DateTime currentDate = DateTime.now();
    Duration difference = (currentDate).difference(deletedDate);
    _days = difference.inDays;
    notifyListeners();
  }

  Future<void> deleteTrashNote() async {
    _isLoading = true;
    await getNotes();
    for (final note in notes) {
      if (note["status"] == "deleted") {
        await calculateDays(id: note["id"]);
        if (days >= 7) {
          await _databaseService.permanentDeleteNote(id: note["id"]);
          await getNotes();
          notifyListeners();
        }
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}
