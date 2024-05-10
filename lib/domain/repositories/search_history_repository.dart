abstract class SearchHistoryRepository {
  Future<void> addSearchHistory(String query);
  Future<List<String>> getSearchHistories();
}
