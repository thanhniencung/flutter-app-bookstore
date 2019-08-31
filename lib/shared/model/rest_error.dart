class RestError {
  String message;

  RestError({this.message});

  factory RestError.fromData(String msg) {
    return RestError(
      message: msg,
    );
  }
}
