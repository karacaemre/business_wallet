class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class Result<T> {
  T? data;
  Error? error;

  Result(this.data, this.error);

  T? get getData {
    return data;
  }

  Error? get getError {
    return error;
  }
}

class Error {
  final String error;

  String get getString{
    return error;
  }

  Error(this.error);
}
