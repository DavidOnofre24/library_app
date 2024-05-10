import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/domain/use_cases/book_search_by_query_use_case.dart';
import 'package:mockito/mockito.dart';

class MockBookRepository extends Mock implements BookRepository {
  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    return super.noSuchMethod(
      Invocation.method(#searchBooks, [query]),
      returnValue: <BookEntity>[],
      returnValueForMissingStub: <BookEntity>[],
    );
  }
}

void main() {
  group('BookSearchByQueryUseCase', () {
    late BookSearchByQueryUseCase useCase;
    late MockBookRepository mockBookRepository;

    setUp(() {
      mockBookRepository = MockBookRepository();
      useCase = BookSearchByQueryUseCase(mockBookRepository);
    });

    test('should return a list of books from the repository', () async {
      // Arrange
      const query = 'Harry Potter';
      final expectedBooks = [
        BookEntity(
            title: 'Harry Potter and the Sorcerer\'s Stone',
            subtitle: '',
            isbn13: '1',
            price: '',
            image: '',
            url: ''),
        BookEntity(
            title: 'Harry Potter and the Chamber of Secrets',
            subtitle: '',
            isbn13: '2',
            price: '',
            image: '',
            url: ''),
      ];
      when(mockBookRepository.searchBooks(query))
          .thenAnswer((_) async => expectedBooks);

      // Act
      final result = await useCase.execute(query);

      // Assert
      expect(result, expectedBooks);
      verify(mockBookRepository.searchBooks(query)).called(1);
      verifyNoMoreInteractions(mockBookRepository);
    });
  });
}
