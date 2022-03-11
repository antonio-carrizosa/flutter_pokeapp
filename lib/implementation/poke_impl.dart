import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pokeapp/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';
import 'package:pokeapp/core/repository/poke_repository.dart';

class PokeImplementation extends PokeRepository {
  final pokeApi = dotenv.env['POKE_API'];
  final spriteBaseUrl = dotenv.env['SPRITE_URL'];

  int offset = 0;
  List<Pokemon> cachedPokemons = [];

  @override
  Future<Either<Failure, List<Result>>> getPokeList() async {
    try {
      final url = Uri.parse('$pokeApi?limit=10&offset=$offset');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> pokeList = data['results'];
        if (pokeList.isEmpty) {
          return const Left(Failure.NoMoreItems);
        }
        final pokemons = List.generate(10, (index) {
          final result = Result.fromJson(pokeList[index]);
          final id = offset == 0 ? index + 1 : offset + index + 1;
          return result.copyWith(id: id);
        });
        offset += 10;
        return Right(pokemons);
      }
      return const Left(Failure.UnexpectedFailure);
    } on SocketException {
      return const Left(Failure.SocketFailure);
    } on TimeoutException {
      return const Left(Failure.TimeoutFailure);
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(String id) async {
    final cachedPokemon = getFromCahe(id);
    if (cachedPokemon != null) {
      return Right(cachedPokemon);
    }

    try {
      final url = Uri.parse('$pokeApi/$id');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 404) {
        return const Left(Failure.ItemNotFounded);
      }
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final pokemon = Pokemon.fromJson(data);
        addToCache(pokemon);
        return Right(pokemon);
      }

      return const Left(Failure.UnexpectedFailure);
    } on SocketException {
      return const Left(Failure.SocketFailure);
    } on TimeoutException {
      return const Left(Failure.TimeoutFailure);
    } on FormatException {
      return const Left(Failure.ItemNotFounded);
    }
  }

  void addToCache(Pokemon pokemon) {
    cachedPokemons = [
      ...cachedPokemons.where((p) => p.id != pokemon.id),
      pokemon
    ];
  }

  Pokemon? getFromCahe(String id) {
    List<Pokemon> pokemons = [];
    final idPk = int.tryParse(id);
    if (idPk != null) {
      pokemons = cachedPokemons.where((p) => p.id == idPk).toList();
    } else {
      pokemons = cachedPokemons.where((p) => p.name == id).toList();
    }
    return pokemons.isNotEmpty ? pokemons[0] : null;
  }
}
