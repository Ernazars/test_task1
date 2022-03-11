import 'package:dartz/dartz.dart';
import 'package:test_task1/core/failure.dart';

abstract class AuthorizationRepo {
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, bool>> logout();
}
