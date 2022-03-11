import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/core/hive_box_path.dart';
import 'package:test_task1/core/pref_keys.dart';
import 'package:test_task1/data/hive_adapters/user_hive_type.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/repo/session_repo.dart';
import 'package:test_task1/injection/init_get.dart';

@Injectable(as: SessionRepo)
class RegistrationRepoImpl implements SessionRepo {
  @override
  Future<Either<Failure, UserEntity?>> getActiveUser() async {
    try {
      String? activeUser = getIt<SharedPreferences>().getString(PrefKeys.user);
      if (activeUser != null) {
        final db = await Hive.openBox(HiveBoxPath.user);
        UserHiveType user = db.get(activeUser);
        await db.close();
        return Right(user.toEntity());
      } else {
        return const Right(null);
      }
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> haveUsers() async {
    try {
      final db = await Hive.openBox(HiveBoxPath.user);
      bool haveUsers = db.isNotEmpty;
      await db.close();
      return Right(haveUsers);
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
