import 'package:copper/core/network/network_info.dart';
import 'package:copper/core/network/network_info_impl.dart';
import 'package:copper/core/presentation/util/input_converter.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_local_data_source_impl.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_remote_data_source_impl.dart';
import 'package:copper/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:copper/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:copper/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:copper/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void init() {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(() {
    return NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      inputConverter: sl(),
      getRandomNumberTrivia: sl(),
    );
  });

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

// Repository
  sl.registerLazySingleton<NumberTriviaRepository>(() =>
      NumberTriviaRepositoryImpl(
          remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! External
  sl.registerSingletonAsync(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
