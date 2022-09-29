import 'package:copper/core/error/failures.dart';
import 'package:copper/core/usecases/usecase.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:copper/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetRandomNumberTrivia extends Usecase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return repository.getRandomNumberTrivia();
  }
}
