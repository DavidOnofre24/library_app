import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepository;
  BookCubit({required this.bookRepository}) : super(BookInitial());

  void getReleaseBooks() async {
    emit(BookLoading());
    try {
      final books = await bookRepository.getNewReleaseBooks();
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}
