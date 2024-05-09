import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

part 'book_detail_state.dart';

class BookDetailCubit extends Cubit<BookDetailState> {
  final BookRepository bookRepository;
  BookDetailCubit({required this.bookRepository}) : super(BookDetailInitial());

  void getBookDetail(String isbn13) async {
    emit(BookDetailLoading());
    try {
      final book = await bookRepository.getBookDetail(isbn13);
      emit(BookDetailLoaded(book));
    } catch (e) {
      emit(BookDetailError(e.toString()));
    }
  }
}
