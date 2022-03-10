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
        offset += 10;
        return Right(pokeList.map((p) => Result.fromJson(p)).toList());
      }
      print(data);
      return Left(UnexpectedFailure());
    } on SocketException catch (e) {
      print(e);
      return Left(SocketFailure());
    } on TimeoutException catch (e) {
      return Left(TimeoutFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemon() {
    // TODO: implement getPokemon
    throw UnimplementedError();
  }
}
