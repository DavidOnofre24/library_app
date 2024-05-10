import 'package:library_app/domain/repositories/search_history_repository.dart';
import 'package:library_app/infrastructure/datasource/search_history_datasource.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final SearchHistoryDatasource dataSource;

  SearchHistoryRepositoryImpl(this.dataSource);

  @override
  Future<void> addSearchHistory(String query) async {
    await dataSource.addSearchHistory(query);
  }

  @override
  Future<List<String>> getSearchHistories() async {
    return dataSource.getSearchHistories();
  }
}
