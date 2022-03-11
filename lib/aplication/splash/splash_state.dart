import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';

/// Representation of the Splash State
/// it can be:
///
///  [Loading], [Loaded] or [Error]
///
/// [Loaded] receives a non nullable `List<Result>` results
///
/// [Error] receives a non nullable value from enum `Failure`.
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
