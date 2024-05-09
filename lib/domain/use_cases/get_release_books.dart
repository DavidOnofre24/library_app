import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

class GetReleaseBooks {
  final BookRepository _bookRepository;

  GetReleaseBooks(this._bookRepository);

  Future<List<BookEntity>> execute() async {
    return await _bookRepository.getNewReleaseBooks();
  }
}
