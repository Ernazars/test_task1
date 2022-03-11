import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/core/hive_box_path.dart';
import 'package:test_task1/core/pref_keys.dart';
import 'package:test_task1/data/hive_adapters/user_hive_type.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/repo/registration_repo.dart';
import 'package:test_task1/injection/init_get.dart';

@Injectable(as: RegistrationRepo)
class RegistrationRepoImpl implements RegistrationRepo {
  @override
  Future<Either<Failure, bool>> toRegistration(
      {required UserEntity user}) async {
    try {
      final db = await Hive.openBox(HiveBoxPath.user);
      db.put(user.email, UserHiveType.fromEntity(user: user));
      SharedPreferences preferences = getIt<SharedPreferences>();
      preferences.setString(PrefKeys.user, user.email);
      preferences.setString(PrefKeys.lastActiveUser, user.email);
      await db.close();
      return const Right(true);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
