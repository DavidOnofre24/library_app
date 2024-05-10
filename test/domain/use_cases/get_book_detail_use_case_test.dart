import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/domain/use_cases/get_book_detail_use_case.dart';
import 'package:mockito/mockito.dart';

class MockBookRepository extends Mock implements BookRepository {
  @override
  Future<BookDetailEntity> getBookDetail(String isbn13) async {
    return super.noSuchMethod(
      Invocation.method(#getBookDetail, [isbn13]),
      returnValue: BookDetailEntity(
          title: 'Harry Potter and the Sorcerer\'s Stone',
          subtitle: '',
          authors: 'J.K. Rowling',
          publisher: 'Scholastic Inc.',
          isbn13: '1234567890',
          pages: '309',
          year: '1997',
          rating: '4.5',
          desc:
              'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry\'s eleventh birthday, a great beetle-eyed',
          price: '',
          image: '',
          url: ''),
      returnValueForMissingStub: BookDetailEntity(
        title: 'Harry Potter and the Sorcerer\'s Stone',
        subtitle: '',
        authors: 'J.K. Rowling',
        publisher: 'Scholastic Inc.',
        isbn13: '1234567890',
        pages: '309',
        year: '1997',
        rating: '4.5',
        desc:
            'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry\'s eleventh birthday, a great beetle-eyed',
        price: '',
        image: '',
        url: '',
      ),
    );
  }
}

void main() {
  group('GetBookDetailUseCase', () {
    late GetBookDetailUseCase useCase;
    late MockBookRepository mockRepository;

    setUp(() {
      mockRepository = MockBookRepository();
      useCase = GetBookDetailUseCase(mockRepository);
    });

    test('should return a BookDetailEntity', () async {
      // Arrange
      const isbn13 = '1234567890';
      final expectedBookDetail = BookDetailEntity(
          title: 'Harry Potter and the Sorcerer\'s Stone',
          subtitle: '',
          authors: 'J.K. Rowling',
          publisher: 'Scholastic Inc.',
          isbn13: '1234567890',
          pages: '309',
          year: '1997',
          rating: '4.5',
          desc:
              'Harry Potter has never even heard of Hogwarts when the letters start dropping on the doormat at number four, Privet Drive. Addressed in green ink on yellowish parchment with a purple seal, they are swiftly confiscated by his grisly aunt and uncle. Then, on Harry\'s eleventh birthday, a great beetle-eyed',
          price: '',
          image: '',
          url: '');
      when(mockRepository.getBookDetail(isbn13))
          .thenAnswer((_) async => expectedBookDetail);

      // Act
      final result = await useCase.execute(isbn13);

      // Assert
      expect(result, equals(expectedBookDetail));
      verify(mockRepository.getBookDetail(isbn13)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
