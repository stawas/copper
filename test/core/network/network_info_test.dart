import 'package:copper/core/network/network_info_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<InternetConnectionChecker>(as: #MockInternetConnectionChecker)
])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      //arrange
      final tHasConntectionFuture = Future.value(true);

      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConntectionFuture);
      //act
      // NOTICE: We're NOT awaiting the result
      final result = networkInfo.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, tHasConntectionFuture);
    });
  });
}
