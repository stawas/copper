import 'dart:convert';

import 'package:copper/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:copper/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text');

  test('shou be a subclass of trivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test('should return a valid model when JSON number is an integer',
        () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });

  group('toJson', () {
    test('should return a json map containing the proper data', () async {
      final result = tNumberTriviaModel.toJson();

      final expectedJsonMap = {
        "text": "Test text",
        "number": 1,
      };

      expect(result, expectedJsonMap);
    });
  });
}
