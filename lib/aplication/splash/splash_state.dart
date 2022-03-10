import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';

abstract class SplashState {}

class Loading extends SplashState {}

class Loaded extends SplashState {
  final List<Result> results;

  Loaded({
    required this.results,
  });

  Loaded copyWith({List<Result>? results}) =>
      Loaded(results: results ?? this.results);
}

class Error extends SplashState {
  final Failure failure;

  Error({required this.failure});
}
