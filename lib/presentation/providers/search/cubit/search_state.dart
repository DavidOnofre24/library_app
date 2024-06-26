part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {
  final List<String> searchHistories;
  const SearchInitial({required this.searchHistories});
}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<BookEntity> items;

  const SearchLoaded(this.items);

  @override
  List<Object> get props => [items];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
