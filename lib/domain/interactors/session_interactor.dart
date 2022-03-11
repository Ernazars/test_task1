import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/repo/session_repo.dart';

@injectable
class SessionInteractor {
  final SessionRepo _sessionRepo;

  SessionInteractor(this._sessionRepo);

  Future<Either<Failure, UserEntity?>> getActiveUser() async =>
      await _sessionRepo.getActiveUser();

  Future<Either<Failure, bool>> haveUsers() async =>
      await _sessionRepo.haveUsers();
}
