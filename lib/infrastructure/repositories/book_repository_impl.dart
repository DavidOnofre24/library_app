import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/infrastructure/datasource/books_datasource.dart';

class BookRepositoryImpl extends BookRepository {
  final BooksDataSource _booksDataSource;

  BookRepositoryImpl(this._booksDataSource);
  @override
  Future<BookDetailEntity> getBookDetail(String isbn13) {
    return _booksDataSource.getBookDetail(isbn13);
  }

  @override
  Future<List<BookEntity>> getNewReleaseBooks() {
    return _booksDataSource.getNewReleaseBooks();
  }

  @override
  Future<List<BookEntity>> searchBooks(String query) {
    return _booksDataSource.searchBooks(query);
  }
}
