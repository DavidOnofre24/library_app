import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:library_app/domain/repositories/book_repository.dart';
import 'package:library_app/domain/repositories/search_history_repository.dart';
import 'package:library_app/domain/use_cases/add_search_history_use_case.dart';
import 'package:library_app/domain/use_cases/book_search_by_query_use_case.dart';
import 'package:library_app/domain/use_cases/get_book_detail_use_case.dart';
import 'package:library_app/domain/use_cases/get_release_books_use_case.dart';
import 'package:library_app/domain/use_cases/get_search_history_use_case.dart';
import 'package:library_app/infrastructure/datasource/api_books_datasource.dart';
import 'package:library_app/infrastructure/datasource/books_datasource.dart';
import 'package:library_app/infrastructure/datasource/local_search_history_datasource.dart';
import 'package:library_app/infrastructure/datasource/search_history_datasource.dart';
import 'package:library_app/infrastructure/repositories/book_repository_impl.dart';
import 'package:library_app/infrastructure/repositories/search_history_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  await getIt.reset();
  await configureSharedPreferences();

  configureDio();
  configureDatasources();
  configureRepositories();
  configureUseCases();
}

configureDio() {
  getIt.registerSingleton<Dio>(
    Dio(),
  );
}

Future<void> configureSharedPreferences() async {
  getIt.registerSingleton<SharedPreferences>(
    await SharedPreferences.getInstance(),
  );
}

configureDatasources() {
  getIt.registerSingleton<BooksDataSource>(
    ApiBooksDatasource(
      dio: getIt(),
    ),
  );

  getIt.registerSingleton<SearchHistoryDatasource>(LocalSearchHistoryDatasource(
    sharedPreferences: getIt(),
  ));
}

configureRepositories() {
  getIt.registerSingleton<BookRepository>(
    BookRepositoryImpl(
      getIt(),
    ),
  );

  getIt.registerSingleton<SearchHistoryRepository>(
    SearchHistoryRepositoryImpl(
      getIt(),
    ),
  );
}

configureUseCases() {
  getIt.registerSingleton<GetReleaseBooksUseCase>(
    GetReleaseBooksUseCase(
      getIt(),
    ),
  );

  getIt.registerSingleton<GetBookDetailUseCase>(
    GetBookDetailUseCase(
      getIt(),
    ),
  );

  getIt.registerSingleton<BookSearchByQueryUseCase>(
    BookSearchByQueryUseCase(
      getIt(),
    ),
  );

  getIt.registerSingleton<AddSearchHistoryUseCase>(
    AddSearchHistoryUseCase(
      getIt(),
    ),
  );

  getIt.registerSingleton<GetSearchHistoryUseCase>(
    GetSearchHistoryUseCase(
      getIt(),
    ),
  );
}
