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

  Future<void> _init() async {
    final pokeList = await _pokeRepository.getPokeList();
    pokeList.fold(
      (Failure f) {
        state = Error(failure: f);
      },
      (List<Result> pokeList) {
        state = Loaded(results: pokeList);
      },
    );
  }

  Future<void> retry() async {
    state = Loading();
    _init();
  }
}
