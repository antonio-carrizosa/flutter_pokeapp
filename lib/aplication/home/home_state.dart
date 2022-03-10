import 'package:dartz/dartz.dart';

import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';

class HomeState {
  final List<Result> pokemons;
  final bool loading;
  final Option<Failure> failureOption;

  HomeState(
      {required this.pokemons,
      this.loading = false,
      required this.failureOption});

  factory HomeState.initial() {
    return HomeState(
      pokemons: [],
      failureOption: const None(),
    );
  }

  HomeState copyWith({
    List<Result>? pokemons,
    bool? loading,
    Option<Failure>? failureOption,
  }) {
    return HomeState(
      pokemons: pokemons ?? this.pokemons,
      loading: loading ?? this.loading,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
