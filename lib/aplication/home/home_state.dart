import 'package:dartz/dartz.dart';

import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';

class HomeState {
  final List<Result> results;
  final bool loading;
  final Option<Failure> failureOption;
  final bool searching;
  final Pokemon? founded;

  HomeState(
      {required this.results,
      this.loading = false,
      required this.failureOption,
      this.searching = false,
      required this.founded});

  factory HomeState.initial() {
    return HomeState(
      results: [],
      founded: null,
      failureOption: const None(),
    );
  }

  HomeState copyWith({
    List<Result>? results,
    Pokemon? founded,
    bool? loading,
    bool? searching,
    Option<Failure>? failureOption,
  }) {
    return HomeState(
      results: results ?? this.results,
      founded: founded,
      loading: loading ?? this.loading,
      searching: searching ?? this.searching,
      failureOption: failureOption ?? this.failureOption,
    );
  }
}
