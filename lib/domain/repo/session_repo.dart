import 'package:dartz/dartz.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/user_entity.dart';

abstract class SessionRepo {
  Future<Either<Failure, UserEntity?>> getActiveUser();
  Future<Either<Failure, bool>> haveUsers();
}
