import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';

class GetReleaseBooksUseCase {
  final BookRepository _bookRepository;

  GetReleaseBooksUseCase(this._bookRepository);

  Future<List<BookEntity>> execute() async {
    return await _bookRepository.getNewReleaseBooks();
  }
}
