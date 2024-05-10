import 'package:library_app/domain/repositories/search_history_repository.dart';

class GetSearchHistoryUseCase {
  final SearchHistoryRepository _searchHistoryRepository;

  GetSearchHistoryUseCase(this._searchHistoryRepository);

  Future<List<String>> execute() {
    return _searchHistoryRepository.getSearchHistories();
  }
}
