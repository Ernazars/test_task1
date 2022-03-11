import 'package:dartz/dartz.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/sunrise_entity.dart';

abstract class SunriseRepo {
  Future<Either<Failure, SunriseEntity>> fetchData();
}
