import 'package:dartz/dartz.dart';
import 'package:pokeapp/core/failures/failures.dart';
import 'package:pokeapp/core/models/pokemon.dart';
import 'package:pokeapp/core/models/result.dart';

abstract class PokeRepository {
  /// Sends a HTTP GET request to https://pokeapi.co/api/v2/pokemon?limit=10&offset=10
  ///
  /// Returns `Either<Failure, List<Result>>`, it doesn't throw exceptions
  /// there are just returned on the normal data flow.
  ///
  /// Returns a `List<Result>` if the request completes on the Right side of Either
  ///
  /// Failures are a enum of type `Failure`
  ///
  /// Failures that can be returned on the Left side of `Either`
  /// [UnexpectedFailure] , [SocketFailure], [TimeoutFailure]
  Future<Either<Failure, List<Result>>> getPokeList();

  /// Sends a HTTP GET request to https://pokeapi.co/api/v2/pokemon/id
  ///
  /// Returns `Either<Failure, List<Result>>`, it doesn't throw exceptions
  /// there are just returned on the normal data flow.
  ///
  /// Returns a `Pokemon` if the request completes on the Right side of Either
  ///
  /// Returns `Either<Failure, Pokemon>`, it doesn't throw exceptions
  /// there are just returned on the normal data flow.
  ///
  /// Failures are a enum of type `Failure`
  ///
  /// Failures that can be returned on the Left side of `Either`
  /// [ItemNotFounded], [UnexpectedFailure] , [SocketFailure], [TimeoutFailure]
  Future<Either<Failure, Pokemon>> getPokemon(String id);
}
