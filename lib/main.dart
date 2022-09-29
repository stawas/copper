import 'package:copper/features/number_trivia/presentation/pages/number_trivai_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'injection_container.dart' as di;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await GetIt.instance.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Number Trivia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.green.shade800, secondary: Colors.green.shade600),
        ),
        home: NumberTriviaPage(
          key: key,
        ));
  }
}
