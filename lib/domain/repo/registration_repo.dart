import 'package:dartz/dartz.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/user_entity.dart';

abstract class RegistrationRepo {
  Future<Either<Failure, bool>> toRegistration({required UserEntity user});
}
