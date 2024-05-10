import 'package:library_app/domain/repositories/search_history_repository.dart';

class AddSearchHistoryUseCase {
  final SearchHistoryRepository _searchHistoryRepository;

  AddSearchHistoryUseCase(this._searchHistoryRepository);

  Future<void> execute(String query) async {
    await _searchHistoryRepository.addSearchHistory(query);
  }
}
