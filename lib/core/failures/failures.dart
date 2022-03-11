/// Failures enum that can be returned from HTTP Requests:
///
/// [SocketFailure],
/// [UnexpectedFailure],
/// [TimeoutFailure],
/// [NoMoreItems],
/// [ItemNotFounded]
enum Failure {
  SocketFailure,
  UnexpectedFailure,
  TimeoutFailure,
  NoMoreItems,
  ItemNotFounded
}
