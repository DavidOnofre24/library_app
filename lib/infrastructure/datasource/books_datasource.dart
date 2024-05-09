import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/entities/book_entity.dart';

abstract class BooksDataSource {
  Future<List<BookEntity>> getNewReleaseBooks();
  Future<BookDetailEntity> getBookDetail(String isbn13);
  Future<List<BookEntity>> searchBooks(String query);
}
