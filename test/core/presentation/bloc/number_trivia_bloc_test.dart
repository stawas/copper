import 'package:copper/core/error/failures.dart';
import 'package:copper/core/presentation/util/input_converter.dart';
import 'package:copper/core/usecases/usecase.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:copper/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<GetConcreteNumberTrivia>(as: #MockGetConcreteNumberTrivia)
])
@GenerateMocks([], customMocks: [
  MockSpec<GetRandomNumberTrivia>(as: #MockGetRandomNumberTrivia)
])
@GenerateMocks([],
    customMocks: [MockSpec<InputConverter>(as: #MockInputConverter)])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be empty', () {
    //assert
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    void setUpMockGetConcreteNumberTriviaSuccess() =>
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    test(
        'should call the InputConverter to validate and convert the string to an unsigned integer',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test('sould emit [Error] when the input is invalid', () {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Left(InvalidInputFailure()));
      //assert later
      final expected = [
        Error(message: invalidInputFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should get data from the concrete use case', () async {
      //arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      setUpMockInputConverterSuccess();
      setUpMockGetConcreteNumberTriviaSuccess();
      //assert later
      final expected = [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] when gettting data fail', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: serverFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test('should emit [Loading, Error] with a proper message when gettting data fails', () async {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });
  });

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    void setUpMockGetRandomNumberTriviaSuccess() =>
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

    test('should get data from the random use case', () async {
      //arrange
      setUpMockGetRandomNumberTriviaSuccess();
      //act
      bloc.add(GetTriviaForRandomNumber());
      await untilCalled(mockGetRandomNumberTrivia(any));
      //assert
      verify(mockGetRandomNumberTrivia(NoParams()));
    });

    test('should emit [Loading, Loaded] when data is gotten successfully',
        () async {
      //arrange
      setUpMockGetRandomNumberTriviaSuccess();
      //assert later
      final expected = [
        Loading(),
        Loaded(trivia: tNumberTrivia),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] when gettting data fail', () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(ServerFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: serverFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });

    test('should emit [Loading, Error] with a proper message when gettting data fails', () async {
      //arrange
      when(mockGetRandomNumberTrivia(any))
          .thenAnswer((_) async => Left(CacheFailure()));
      //assert later
      final expected = [
        Loading(),
        Error(message: cacheFailureMessage),
      ];
      expectLater(bloc.stream, emitsInOrder(expected));
      //act
      bloc.add(GetTriviaForRandomNumber());
    });
  });

}
