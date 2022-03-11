import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/core/failure.dart';
import 'package:test_task1/domain/entities/sunrise_entity.dart';
import 'package:test_task1/domain/repo/sunrise_repo.dart';

@injectable
class SunriseInteractor{
  final SunriseRepo _sunriseRepo;

  SunriseInteractor(this._sunriseRepo);

  Future<Either<Failure, SunriseEntity>> fetchData()async=>_sunriseRepo.fetchData();
}