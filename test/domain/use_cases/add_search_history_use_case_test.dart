import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/domain/repositories/search_history_repository.dart';
import 'package:library_app/domain/use_cases/add_search_history_use_case.dart';
import 'package:mockito/mockito.dart';

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {
  @override
  Future<void> addSearchHistory(String query) async {
    return super.noSuchMethod(
      Invocation.method(#addSearchHistory, [query]),
      returnValue: null,
      returnValueForMissingStub: null,
    );
  }
}

void main() {
  group('AddSearchHistoryUseCase', () {
    late AddSearchHistoryUseCase addSearchHistoryUseCase;
    late MockSearchHistoryRepository mockSearchHistoryRepository;

    setUp(() {
      mockSearchHistoryRepository = MockSearchHistoryRepository();
      addSearchHistoryUseCase =
          AddSearchHistoryUseCase(mockSearchHistoryRepository);
    });

    test('should add search history to repository', () async {
      // Arrange
      const query = 'example query';

      // Act
      await addSearchHistoryUseCase.execute(query);

      // Assert
      verify(mockSearchHistoryRepository.addSearchHistory(query)).called(1);
    });
  });
}
