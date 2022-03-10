import 'package:dartz/dartz.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';

abstract class PokeRepository {
  Future<Either<Failure, List<Result>>> getPokeList();
  Future<Either<Failure, Pokemon>> getPokemon(int id);
}
