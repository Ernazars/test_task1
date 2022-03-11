import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/core/hive_box_path.dart';
import 'package:test_task1/core/pref_keys.dart';
import 'package:test_task1/data/hive_adapters/user_hive_type.dart';
import 'package:test_task1/domain/repo/authorization_repo.dart';
import 'package:test_task1/injection/init_get.dart';

@Injectable(as: AuthorizationRepo)
class RegistrationRepoImpl implements AuthorizationRepo {
  @override
  Future<Either<Failure, bool>> login(
      {required String email, required String password}) async {
    try {
      final db = await Hive.openBox(HiveBoxPath.user);
      UserHiveType user = db.get(email);
      await db.close();
      if (user.password == password) {
        SharedPreferences preferences = getIt<SharedPreferences>();
        preferences.setString(PrefKeys.user, user.email);
        preferences.setString(PrefKeys.lastActiveUser, user.email);
        return const Right(true);
      } else {
        return const Left(
          Failure(message: "Не верные учетные данные!"),
        );
      }
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      SharedPreferences preferences = getIt<SharedPreferences>();
      String? activeUser = preferences.getString(PrefKeys.user);
      if (activeUser != null) {
        if (await preferences.remove(PrefKeys.user)) {
          return const Right(true);
        } else {
          return const Left(
            Failure(message: "Не удалось выйти с учетной записи!"),
          );
        }
      } else {
        return const Left(
          Failure(message: "Не удалось найти учетную запись!"),
        );
      }
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
