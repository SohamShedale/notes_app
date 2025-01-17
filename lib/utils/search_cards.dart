import 'package:authentication/constants/data.dart';
import 'package:authentication/pages/data_list.dart';

List<DataItem> searchCards(String value) {
  List<DataItem> searchedData = [];
  if (value.isEmpty) {
    return searchedData;
  }
  return searchedData = dataItem
      .where((singleData) =>
          singleData.title.toLowerCase().contains(value.toLowerCase()) ||
          singleData.description.toLowerCase().contains(value.toLowerCase()))
      .toList();
}
