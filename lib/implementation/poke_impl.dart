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

  @override
  Future<Either<Failure, List<Result>>> getPokeList() async {
    try {
      final url = Uri.parse('$pokeApi?limit=10&offset=$offset');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> pokeList = data['results'];
        if (pokeList.isEmpty) {
          return Left(NoMoreItems());
        }
        final pokemons = List.generate(10, (index) {
          final result = Result.fromJson(pokeList[index]);
          final id = offset == 0 ? index + 1 : offset + index;
          return result.copyWith(id: id);
        });
        offset += 10;
        return Right(pokemons);
      }

      return Left(UnexpectedFailure());
    } on SocketException {
      return Left(SocketFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon(String id) async {
    try {
      final url = Uri.parse('$pokeApi/$id');
      final response = await http.get(url).timeout(const Duration(seconds: 5));
      if (response.statusCode == 400) {
        return Left(ItemNotFounded());
      }
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(Pokemon.fromJson(data));
      }

      return Left(UnexpectedFailure());
    } on SocketException {
      return Left(SocketFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } on FormatException {
      return Left(ItemNotFounded());
    }
  }
}
