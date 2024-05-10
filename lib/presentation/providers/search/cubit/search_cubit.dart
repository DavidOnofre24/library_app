import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/use_cases/add_search_history_use_case.dart';
import 'package:library_app/domain/use_cases/book_search_by_query_use_case.dart';
import 'package:library_app/domain/use_cases/get_search_history_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final Duration debounceDuration = const Duration(milliseconds: 800);
  Timer? _debounceTimer;
  final BookSearchByQueryUseCase bookSearchByQuery;
  final AddSearchHistoryUseCase addSearchHistoryUseCase;
  final GetSearchHistoryUseCase getSearchHistoryUseCase;

  SearchCubit({
    required this.bookSearchByQuery,
    required this.addSearchHistoryUseCase,
    required this.getSearchHistoryUseCase,
  }) : super(const SearchInitial(searchHistories: []));

  void getSearchHistories() async {
    final searchHistories = await getSearchHistoryUseCase.execute();
    emit(SearchInitial(searchHistories: searchHistories));
  }

  void search(String query) {
    emit(SearchLoading());
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(debounceDuration, () async {
      try {
        final searchItems = await bookSearchByQuery.execute(query);
        await addSearchHistoryUseCase.execute(query);
        emit(SearchLoaded(searchItems));
      } catch (e) {
        emit(const SearchError('No books found'));
      }
    });
  }

  void clearSearch() {
    getSearchHistories();
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }
  }
}
