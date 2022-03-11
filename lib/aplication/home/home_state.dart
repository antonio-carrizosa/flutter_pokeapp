import 'package:dartz/dartz.dart';

import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';

class HomeState {
  final List<Result> pokemons;
  final bool loading;
  final Option<Failure> failureOption;
  final bool searching;
  final Pokemon? founded;

  HomeState(
      {required this.pokemons,
      this.loading = false,
      required this.failureOption,
      this.searching = false,
      required this.founded});

  factory HomeState.initial() {
    return HomeState(
      pokemons: [],
      founded: null,
      failureOption: const None(),
    );
  }

  HomeState copyWith({
    List<Result>? pokemons,
    Pokemon? founded,
    bool? loading,
    bool? searching,
    Option<Failure>? failureOption,
  }) {
    return HomeState(
      pokemons: pokemons ?? this.pokemons,
      founded: founded,
      loading: loading ?? this.loading,
      searching: searching ?? this.searching,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
