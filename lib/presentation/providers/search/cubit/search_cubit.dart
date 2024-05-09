import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/use_cases/book_search_by_query.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final Duration debounceDuration = const Duration(milliseconds: 800);
  Timer? _debounceTimer;
  final BookSearchByQuery bookSearchByQuery;

  SearchCubit({required this.bookSearchByQuery}) : super(SearchInitial());

  void search(String query) {
    emit(SearchLoading());
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(debounceDuration, () async {
      try {
        final searchItems = await bookSearchByQuery.execute(query);
        emit(SearchLoaded(searchItems));
      } catch (e) {
        emit(const SearchError('No books found'));
      }
    });
  }

  void clearSearch() {
    emit(SearchInitial());
    if (_debounceTimer != null && _debounceTimer!.isActive) {
      _debounceTimer!.cancel();
    }
  }
}
