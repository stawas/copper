import 'dart:convert';

import 'package:copper/core/error/exception.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:copper/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedNumberTrivia = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(cachedNumberTrivia);
    if (jsonString != null) {
      // Future which is immediately completed
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferences.setString(
        cachedNumberTrivia, json.encode(triviaToCache.toJson()));
  }
}
