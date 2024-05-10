import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/domain/repositories/repositories.dart';
import 'package:library_app/domain/use_cases/get_search_history_use_case.dart';
import 'package:mockito/mockito.dart';

class MockSearchHistoryRepository extends Mock
    implements SearchHistoryRepository {
  @override
  Future<List<String>> getSearchHistories() async {
    return super.noSuchMethod(
      Invocation.method(#getSearchHistories, []),
      returnValue: <String>[],
      returnValueForMissingStub: <String>[],
    );
  }
}

void main() {
  group('GetSearchHistoryUseCase', () {
    late GetSearchHistoryUseCase useCase;
    late MockSearchHistoryRepository mockRepository;

    setUp(() {
      mockRepository = MockSearchHistoryRepository();
      useCase = GetSearchHistoryUseCase(mockRepository);
    });

    test('should return a list of search histories', () async {
      // Arrange
      final expectedHistories = ['history1', 'history2'];
      when(mockRepository.getSearchHistories())
          .thenAnswer((_) async => expectedHistories);

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, expectedHistories);
      verify(mockRepository.getSearchHistories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
