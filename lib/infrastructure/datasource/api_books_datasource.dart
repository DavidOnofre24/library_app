import 'package:dio/dio.dart';
import 'package:library_app/domain/entities/book_detail_entity.dart';
import 'package:library_app/domain/entities/book_entity.dart';
import 'package:library_app/infrastructure/datasource/books_datasource.dart';
import 'package:library_app/infrastructure/mappers/book_detail_mapper.dart';
import 'package:library_app/infrastructure/mappers/books_mapper.dart';
import 'package:library_app/infrastructure/models/book_detail_response.dart';
import 'package:library_app/infrastructure/models/book_response.dart';

class ApiBooksDatasource extends BooksDataSource {
  final Dio dio;

  ApiBooksDatasource({required this.dio});
  @override
  Future<BookDetailEntity> getBookDetail(String isbn13) async {
    final response =
        await dio.get('https://api.itbook.store/1.0/books/$isbn13');

    if (response.statusCode == 200) {
      final bookDetailResponse = BookDetailResponse.fromJson(response.data);
      return BookDetailMapper.bookDetailResponseToEntity(bookDetailResponse);
    } else {
      throw Exception('Failed to load book detail');
    }
  }

  @override
  Future<List<BookEntity>> getNewReleaseBooks() async {
    final response = await dio.get('https://api.itbook.store/1.0/new');

    if (response.statusCode == 200) {
      final bookResponse = BookResponse.fromJson(response.data);

      return BooksMapper.booksReponseToEntity(bookResponse);
    } else {
      throw Exception('Failed to load new release books');
    }
  }

  @override
  Future<List<BookEntity>> searchBooks(String query) async {
    final response =
        await dio.get('https://api.itbook.store/1.0/search/$query');

    if (response.statusCode == 200) {
      final bookResponse = BookResponse.fromJson(response.data);

      return BooksMapper.booksReponseToEntity(bookResponse);
    } else {
      throw Exception('Failed to search books');
    }
  }
}
