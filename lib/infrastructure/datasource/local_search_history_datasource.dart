import 'package:library_app/infrastructure/datasource/search_history_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSearchHistoryDatasource implements SearchHistoryDatasource {
  final SharedPreferences sharedPreferences;

  LocalSearchHistoryDatasource({required this.sharedPreferences});

  @override
  Future<void> addSearchHistory(String query) async {
    final searchHistories =
        sharedPreferences.getStringList('searchHistories') ?? [];
    searchHistories.remove(query);
    searchHistories.insert(0, query);
    await sharedPreferences.setStringList('searchHistories', searchHistories);
  }

  @override
  Future<List<String>> getSearchHistories() async {
    return sharedPreferences.getStringList('searchHistories') ?? [];
  }
}
