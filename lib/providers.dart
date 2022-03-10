import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokeapp/aplication/home/home_state.dart';
import 'package:pokeapp/aplication/home/home_state_notifier.dart';
import 'package:pokeapp/aplication/splash/splash_state.dart';
import 'package:pokeapp/aplication/splash/splash_state_notifier.dart';

import 'package:pokeapp/core/repository/poke_repository.dart';
import 'package:pokeapp/implementation/poke_impl.dart';

final pokeRepository = Provider<PokeRepository>((_) => PokeImplementation());

final splashStateNotifier =
    StateNotifierProvider<SplashStateNotifier, SplashState>(
  (ref) => SplashStateNotifier(ref.watch(pokeRepository)),
);

final homeStateNotifier = StateNotifierProvider<HomeStateNotifier, HomeState>(
    (ref) => HomeStateNotifier(ref.watch(pokeRepository)));