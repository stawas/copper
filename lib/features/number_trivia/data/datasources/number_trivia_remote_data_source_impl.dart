import 'dart:convert';

import 'package:copper/core/error/exception.dart';
import 'package:copper/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:copper/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart';

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final Client client;

  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getTriviaFromUrl(Uri.parse('http://numbersapi.com/$number'));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromUrl(Uri.parse('http://numbersapi.com/random'));
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(Uri url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
