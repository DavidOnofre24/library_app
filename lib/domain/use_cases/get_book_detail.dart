import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

class GetBookDetail {
  final BookRepository _repository;

  GetBookDetail(this._repository);

  Future<BookDetailEntity> execute(String isbn13) async {
    return await _repository.getBookDetail(isbn13);
  }
}
