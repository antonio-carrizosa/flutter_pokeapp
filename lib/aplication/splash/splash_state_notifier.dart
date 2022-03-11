import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/splash/splash_state.dart';

import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/core/repository/poke_repository.dart';

class SplashStateNotifier extends StateNotifier<SplashState> {
  final PokeRepository _pokeRepository;

  SplashStateNotifier(this._pokeRepository) : super(Loading()) {
    _init();
  }

  /// Try to get a List<Result> results from https://pokeapi.co/
  /// if it can't the updates then state with Error(failure: f).
  Future<void> _init() async {
    final failureOrSuccess = await _pokeRepository.getPokeList();
    failureOrSuccess.fold(
      (Failure f) {
        state = Error(failure: f);
      },
      (List<Result> results) {
        state = Loaded(results: results);
      },
    );
  }

  /// Retry to get a List<Result> results from https://pokeapi.co/
  Future<void> retry() async {
    state = Loading();
    _init();
  }
}
