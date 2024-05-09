import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

class BookSearchByQuery {
  final BookRepository _bookRepository;

  BookSearchByQuery(this._bookRepository);

  Future<List<BookEntity>> execute(String query) async {
    return _bookRepository.searchBooks(query);
  }
}
