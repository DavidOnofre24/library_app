import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

class BookSearchByQueryUseCase {
  final BookRepository _bookRepository;

  BookSearchByQueryUseCase(this._bookRepository);

  Future<List<BookEntity>> execute(String query) async {
    return _bookRepository.searchBooks(query);
  }
}
