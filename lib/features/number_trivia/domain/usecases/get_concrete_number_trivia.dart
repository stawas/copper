import 'package:copper/core/error/failures.dart';
import 'package:copper/core/usecases/usecase.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:copper/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetConcreteNumberTrivia extends Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
