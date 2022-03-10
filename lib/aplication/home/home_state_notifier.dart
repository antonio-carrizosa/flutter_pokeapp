import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/home/home_state.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/core/repository/poke_repository.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final PokeRepository _pokeRepository;

  HomeStateNotifier(this._pokeRepository) : super(HomeState.initial());

  void addPokemons(List<Result> pokemons) {
    state = state.copyWith(
      pokemons: [...state.pokemons, ...pokemons],
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

  void clearError() {
    state = state.copyWith(
      failureOption: const None(),
      loading: false,
    );
  }
}
