import 'package:hive/hive.dart';
import 'package:test_task1/domain/entities/user_entity.dart';

part 'user_hive_type.g.dart';

@HiveType(typeId: 1)
class UserHiveType {
  UserHiveType({
    required this.name,
    required this.email,
    required this.password,
    required this.regDate,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  @HiveField(2)
  String password;

  @HiveField(3)
  int regDate;

  factory UserHiveType.fromEntity({required UserEntity user}) {
    return UserHiveType(
      email: user.email,
      name: user.name,
      password: user.password,
      regDate: user.regDate,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      email: email,
      name: name,
      password: password,
      regDate: regDate,
    );
  }
}
