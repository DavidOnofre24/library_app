import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/domain/use_cases/book_search_by_query.dart';
import 'package:library_app/domain/use_cases/get_book_detail.dart';
import 'package:library_app/domain/use_cases/get_release_books.dart';
import 'package:library_app/infrastructure/datasource/api_books_datasource.dart';
import 'package:library_app/infrastructure/datasource/books_datasource.dart';
import 'package:library_app/infrastructure/repositories/book_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await getIt.reset();

  configureDio();
  configureDatasources();
  configureRepositories();
  configureUseCases();
}

configureDio() {
  getIt.registerSingleton<Dio>(Dio());
}

configureDatasources() {
  getIt.registerSingleton<BooksDataSource>(ApiBooksDatasource(dio: getIt()));
}

configureRepositories() {
  getIt.registerSingleton<BookRepository>(BookRepositoryImpl(getIt()));
}

configureUseCases() {
  getIt.registerSingleton<GetReleaseBooks>(GetReleaseBooks(getIt()));

  getIt.registerSingleton<GetBookDetail>(GetBookDetail(getIt()));

  getIt.registerSingleton<BookSearchByQuery>(BookSearchByQuery(getIt()));
}
