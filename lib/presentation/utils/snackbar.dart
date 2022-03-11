import 'package:flutter/material.dart';
import 'package:pokeapp/core/failures/failures.dart';

void showSnackBar(BuildContext context, Failure f) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(getFailureMessage(f))));
}

/// Returns a readable error message based on a `Failure` enum value.
String getFailureMessage(Failure f) {
  switch (f) {
    case Failure.SocketFailure:
      return "Check your connection.";
    case Failure.UnexpectedFailure:
      return "Unexpected Error";
    case Failure.TimeoutFailure:
      return "Could not establish connection to the server.";
    case Failure.NoMoreItems:
      return "There are no more pokemon.";
    case Failure.ItemNotFounded:
      return "The pokemon was not found.";
  }
}
