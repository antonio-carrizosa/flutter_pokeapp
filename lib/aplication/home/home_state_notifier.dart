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

  List<Result> _pokelist = [];

  void addPokemons(List<Result> pokemons) {
    _pokelist = [..._pokelist, ...pokemons];
    state = state.copyWith(
      pokemons: _pokelist,
      loading: false,
    );
  }

  Future<void> getMorePokemons() async {
    if (!state.loading) {
      state = state.copyWith(
        loading: true,
        failureOption: const None(),
      );
      final pokeList = await _pokeRepository.getPokeList();
      pokeList.fold(
        (Failure f) {
          state = state.copyWith(
            failureOption: Some(f),
            loading: false,
          );
        },
        (List<Result> pokeList) {
          addPokemons(pokeList);
        },
      );
    }
  }

  Future<void> searchPokemon(String term) async {
    if (term.isEmpty) {
      state = state.copyWith(
        pokemons: _pokelist,
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
    state = HomeState.initial().copyWith(pokemons: _pokelist);
  }

  void deletePokemon(int id) {
    state =
        state.copyWith(pokemons: [...state.pokemons.where((p) => p.id != id)]);
  }

  void clearError() {
    state = state.copyWith(
      failureOption: const None(),
      loading: false,
    );
  }
}
