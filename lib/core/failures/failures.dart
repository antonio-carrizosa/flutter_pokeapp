abstract class Failure {}

class SocketFailure extends Failure {}

class UnexpectedFailure extends Failure {}

class TimeoutFailure extends Failure {}

class NoMoreItems extends Failure {}

class ItemNotFounded extends Failure {}
