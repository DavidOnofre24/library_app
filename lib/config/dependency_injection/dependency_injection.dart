import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:library_app/domain/repositories/repositories.dart';
import 'package:library_app/domain/use_cases/use_cases.dart';
import 'package:library_app/infrastructure/datasource/datasources.dart';
import 'package:library_app/infrastructure/repositories/repositories.dart';
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
