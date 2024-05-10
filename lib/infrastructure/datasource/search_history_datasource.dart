abstract class SearchHistoryDatasource {
  Future<void> addSearchHistory(String query);
  Future<List<String>> getSearchHistories();
}
