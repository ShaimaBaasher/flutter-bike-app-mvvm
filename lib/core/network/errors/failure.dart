import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final int statusCode;
  final String message;

  // String get errorMessage => '${statusCode}Error: $message';
  String get errorMessage => message;

  @override
  List<Object> get props => [statusCode, message];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class StringFailure extends Failure {
  const StringFailure({required super.message, required super.statusCode});
  StringFailure.fromException(StringFailure exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
