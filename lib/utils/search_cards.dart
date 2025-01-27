Future<List<Map<String, dynamic>>> searchCards(
    List<Map<String, dynamic>>? data, String value) async {
  List<Map<String, dynamic>> searchedData = [];
  if (value.isEmpty) {
    return data!;
  }
  searchedData = data!
      .where((singleData) =>
          singleData["title"].toLowerCase().contains(value.toLowerCase()) ||
          singleData["description"].toLowerCase().contains(value.toLowerCase()))
      .toList();
  if (searchedData.isNotEmpty) {
    return searchedData;
  }
  return [];
}
