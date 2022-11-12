abstract class AppException implements Exception {
  final String errorMessage;
  AppException(this.errorMessage);
}

class PostSearchException implements AppException {
  @override
  final String errorMessage;
  PostSearchException(this.errorMessage);
}

class PostReachedException implements AppException {
  @override
  String get errorMessage => 'You have Reached end of Results';
}

class SomethingWentWrongException implements AppException {
  @override
  String get errorMessage => 'Oops something went wrong';
}
