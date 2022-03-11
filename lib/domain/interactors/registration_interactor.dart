import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/repo/registration_repo.dart';

@injectable
class RegistrationInteractor {
  final RegistrationRepo _registrationRepo;

  RegistrationInteractor(this._registrationRepo);

  Future<Either<Failure, bool>> toRegistration(
          {required UserEntity user}) async =>
      await _registrationRepo.toRegistration(user: user);
}
