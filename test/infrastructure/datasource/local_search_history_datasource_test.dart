import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/infrastructure/datasource/local_search_history_datasource.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  Future<bool> setStringList(String key, List<String> value) {
    return super.noSuchMethod(
      Invocation.method(#setStringList, [key, value]),
      returnValue: Future.value(true),
      returnValueForMissingStub: Future.value(true),
    );
  }

  @override
  List<String>? getStringList(String key) {
    return super.noSuchMethod(
      Invocation.getter(#getStringList),
      returnValue: <String>[],
      returnValueForMissingStub: <String>[],
    );
  }
}

void main() {
  group('LocalSearchHistoryDatasource', () {
    late LocalSearchHistoryDatasource datasource;
    late MockSharedPreferences sharedPreferences;

    setUp(() {
      sharedPreferences = MockSharedPreferences();
      datasource =
          LocalSearchHistoryDatasource(sharedPreferences: sharedPreferences);
    });

    test('addSearchHistory should add query to searchHistories', () async {
      // Arrange
      const query = 'test query';
      final searchHistories = ['previous query'];
      when(sharedPreferences.getStringList('searchHistories'))
          .thenReturn(searchHistories);

      // Act
      await datasource.addSearchHistory(query);

      // Assert
      verify(await sharedPreferences.setStringList(
              'searchHistories', ['test query', 'previous query']))
          .called(1);

      verify(sharedPreferences.getStringList('searchHistories')).called(1);
    });

    test(
        'addSearchHistory should remove oldest query if searchHistories length exceeds 5',
        () async {
      // Arrange
      const query = 'test query';
      final searchHistories =
          List<String>.generate(5, (index) => 'query $index');
      when(sharedPreferences.getStringList('searchHistories'))
          .thenReturn(searchHistories);

      // Act
      await datasource.addSearchHistory(query);

      // Assert
      verify(await sharedPreferences.setStringList('searchHistories',
              ['test query', 'query 0', 'query 1', 'query 2', 'query 3']))
          .called(1);
    });

    test(
        'getSearchHistories should return empty list if searchHistories is null',
        () async {
      // Arrange
      when(sharedPreferences.getStringList('searchHistories')).thenReturn(null);

      // Act
      final result = await datasource.getSearchHistories();

      // Assert
      expect(result, isEmpty);
    });

    test('getSearchHistories should return searchHistories list', () async {
      // Arrange
      final searchHistories = ['query 1', 'query 2'];
      when(sharedPreferences.getStringList('searchHistories'))
          .thenReturn(searchHistories);

      // Act
      final result = await datasource.getSearchHistories();

      // Assert
      expect(result, equals(searchHistories));
    });
  });
}
