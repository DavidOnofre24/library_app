import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:library_app/domain/entities/entities.dart';
import 'package:library_app/infrastructure/datasource/api_books_datasource.dart';

void main() {
  group('ApiBooksDatasource', () {
    late ApiBooksDatasource apiBooksDatasource;
    late Dio dio;

    setUp(() {
      dio = Dio();
      apiBooksDatasource = ApiBooksDatasource(dio: dio);
    });

    test('getBookDetail returns BookDetailEntity', () async {
      // Arrange
      const isbn13 = '9781617294136';

      // Act
      final result = await apiBooksDatasource.getBookDetail(isbn13);

      // Assert
      expect(result, isA<BookDetailEntity>());
    });

    test('getNewReleaseBooks returns List<BookEntity>', () async {
      // Act
      final result = await apiBooksDatasource.getNewReleaseBooks();

      // Assert
      expect(result, isA<List<BookEntity>>());
    });

    test('searchBooks returns List<BookEntity>', () async {
      // Arrange
      const query = 'flutter';

      // Act
      final result = await apiBooksDatasource.searchBooks(query);

      // Assert
      expect(result, isA<List<BookEntity>>());
    });
  });
}
