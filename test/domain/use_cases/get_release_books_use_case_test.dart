import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/domain/use_cases/get_release_books_use_case.dart';
import 'package:mockito/mockito.dart';

class MockBookRepository extends Mock implements BookRepository {
  @override
  Future<List<BookEntity>> getNewReleaseBooks() async {
    return super.noSuchMethod(
      Invocation.method(#getNewReleaseBooks, []),
      returnValue: <BookEntity>[],
      returnValueForMissingStub: <BookEntity>[],
    );
  }
}

void main() {
  group('GetReleaseBooksUseCase', () {
    late GetReleaseBooksUseCase useCase;
    late MockBookRepository mockBookRepository;

    setUp(() {
      mockBookRepository = MockBookRepository();
      useCase = GetReleaseBooksUseCase(mockBookRepository);
    });

    test('should return a list of books', () async {
      // Arrange
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
      when(mockBookRepository.getNewReleaseBooks())
          .thenAnswer((_) async => expectedBooks);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, expectedBooks);
      verify(mockBookRepository.getNewReleaseBooks()).called(1);
      verifyNoMoreInteractions(mockBookRepository);
    });
  });
}
