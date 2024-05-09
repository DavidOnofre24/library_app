import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/infrastructure/models/book_response.dart';

class BooksMapper {
  static List<BookEntity> booksReponseToEntity(BookResponse response) {
    return response.books
        .map((r) => BookEntity(
            image: r.image ?? '',
            isbn13: r.isbn13 ?? '',
            price: r.price ?? '',
            subtitle: r.subtitle ?? '',
            title: r.title ?? '',
            url: r.url ?? ''))
        .toList();
  }
}
