part of 'book_detail_cubit.dart';

sealed class BookDetailState extends Equatable {
  const BookDetailState();

  @override
  List<Object> get props => [];
}

final class BookDetailInitial extends BookDetailState {}

final class BookDetailLoading extends BookDetailState {}

final class BookDetailLoaded extends BookDetailState {
  final BookDetailEntity book;

  const BookDetailLoaded(this.book);

  @override
  List<Object> get props => [book];
}

final class BookDetailError extends BookDetailState {
  final String message;

  const BookDetailError(this.message);

  @override
  List<Object> get props => [message];
}
