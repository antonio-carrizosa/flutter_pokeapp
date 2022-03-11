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

  void addResults(List<Result> results) {
    _resultList = [..._resultList, ...results];
    state = state.copyWith(
      results: _resultList,
      loading: false,
    );
  }

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

  Future<void> searchPokemon(String term) async {
    if (term.isEmpty) {
      state = state.copyWith(
        results: _resultList,
        founded: null,
        searching: false,
      );
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

  void refresh() {
    state = HomeState.initial().copyWith(results: _resultList);
  }

  void deletePokemon(int id) {
    state =
        state.copyWith(results: [...state.results.where((p) => p.id != id)]);
  }

  void clearError() {
    state = state.copyWith(
      failureOption: const None(),
      loading: false,
    );
  }
}
