import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/home/home_state.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/core/repository/poke_repository.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final PokeRepository _pokeRepository;

  HomeStateNotifier(this._pokeRepository) : super(HomeState.initial());

  List<Result> _resultList = [];

  /// Adds a `List<Result>` in the private list
  /// then updates the `List<Result>` results.
  void addResults(List<Result> results) {
    _resultList = [..._resultList, ...results];
    state = state.copyWith(
      results: _resultList,
      loading: false,
    );
  }

  /// Adds a `List<Result>` in the private list if the request completes
  /// and then updates the `List<Result>` results,
  /// if not then updates de `Option<Failure>` failureOption with `Some(Failure)`.
  Future<void> loadMoreResults() async {
    if (!state.loading) {
      state = state.copyWith(
        loading: true,
        failureOption: const None(),
      );
      final resultList = await _pokeRepository.getPokeList();
      resultList.fold(
        (Failure f) {
          state = state.copyWith(
            failureOption: Some(f),
            loading: false,
          );
        },
        (List<Result> results) {
          addResults(results);
        },
      );
    }
  }

  /// Gets a pokemon based on the given [term] if the  request completes
  /// if not then updates de `Option<Failure>` failureOption with `Some(Failure)`.
  Future<void> searchPokemon(String term) async {
    if (term.isEmpty) {
      state = state.copyWith(
          results: _resultList,
          founded: null,
          searching: false,
          failureOption: const None());
    } else {
      state = state.copyWith(searching: true, founded: null);
      final failureOrSuccess =
          await _pokeRepository.getPokemon(term.toLowerCase());
      failureOrSuccess.fold((f) {
        state = state.copyWith(
          failureOption: Some(f),
          searching: false,
        );
      }, (p) {
        state = state.copyWith(founded: p, searching: false);
      });
    }
  }

  /// Loads the private list in the `List<Result>` results to recover deletes `Result`.
  void refresh() {
    state = HomeState.initial().copyWith(results: _resultList);
  }

  /// Deletes  a `Result` from `List<Result>` results.
  void deletePokemon(int id) {
    state =
        state.copyWith(results: [...state.results.where((p) => p.id != id)]);
  }

  /// Helper method to  set `Option<Failure>` failureOption to `None`.
  void clearError() {
    state = state.copyWith(
      failureOption: const None(),
      loading: false,
    );
  }
}
