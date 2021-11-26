import 'package:flutter/foundation.dart';
import 'package:infinity_scroll_app/models/passanger_model.dart';
import 'package:infinity_scroll_app/services/passanger_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PassangerProvider extends ChangeNotifier {
  bool? _result;
  bool get result => _result!;
  int _currentPage = 1;
  int? _maxPage;
  String _message = "";
  String get message => _message;
  List<Passanger> _listData = [];

  List<Passanger> get listData => _listData;

  Future<void> getDataPassanger(
      {bool isRefresh = false,
      required RefreshController refreshController}) async {
    final data =
        await PassangerService().getPassanger(currentPage: _currentPage);
    if (data != null) {
      if (isRefresh) {
        _currentPage = 1;
        _listData = data.data;
      } else {
        if (_currentPage > _maxPage!) {
          refreshController.loadNoData();
        }
        _listData.addAll(data.data);
      }
      _currentPage++;
      _result = true;
      _maxPage = data.totalPages;
      notifyListeners();
    } else {
      _message = "Cannot retrive data";
      notifyListeners();
    }
  }
}
