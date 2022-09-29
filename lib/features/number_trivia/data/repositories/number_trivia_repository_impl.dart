import 'package:copper/core/error/exception.dart';
import 'package:copper/core/network/network_info.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:copper/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:copper/core/error/failures.dart';
import 'package:copper/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:dartz/dartz.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    return _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    return _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      Future<NumberTrivia> Function() getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia as NumberTriviaModel);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
