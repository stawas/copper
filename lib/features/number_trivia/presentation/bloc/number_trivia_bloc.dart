import 'package:copper/core/error/failures.dart';
import 'package:copper/core/presentation/util/input_converter.dart';
import 'package:copper/core/usecases/usecase.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The number must be a positive integer or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);
      await inputEither.fold((failure) {
        emit(Error(message: invalidInputFailureMessage));
      }, (integer) async {
        emit(Loading());
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
          emit(_eitherLoadedOrErrorState(failureOrTrivia));
      });
    });
    on<GetTriviaForRandomNumber>((event, emit) async {
      emit(Loading());
      final failureOrTrivia = await getRandomNumberTrivia(NoParams());
      emit(_eitherLoadedOrErrorState(failureOrTrivia));
    });
  }

  NumberTriviaState _eitherLoadedOrErrorState(
      Either<Failure, NumberTrivia> failureOrTrivia) {
    return failureOrTrivia.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (trivia) => Loaded(trivia: trivia));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
