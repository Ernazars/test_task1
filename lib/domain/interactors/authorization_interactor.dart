import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/core/failure.dart';

import '../repo/authorization_repo.dart';

@injectable
class AuthorizationInteractor {
  final AuthorizationRepo _authorizationRepo;

  AuthorizationInteractor(this._authorizationRepo);

  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async =>
      await _authorizationRepo.login(
        email: email,
        password: password,
      );

  Future<Either<Failure, bool>> logout() async =>
      await _authorizationRepo.logout();
}
