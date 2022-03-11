import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/core/api_requester.dart';
import 'package:test_task1/data/models/sunrise_model/sunrise_model.dart';
import 'package:test_task1/domain/entities/sunrise_entity.dart';
import 'package:test_task1/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:test_task1/domain/repo/sunrise_repo.dart';

@Injectable(as: SunriseRepo)
class SinriseRepoImpl implements SunriseRepo {
  final ApiRequester _apiRequester;

  SinriseRepoImpl(this._apiRequester);
  @override
  Future<Either<Failure, SunriseEntity>> fetchData() async {
    try {
      var response = await _apiRequester.dio.get(
          "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=2022-02-14");
      return Right(SunriseModel.fromJson(response.data).toEntity());
    } on DioError catch (error) {
      return Left(Failure(message: error.message));
    } catch (error) {
      return Left(Failure(message: error.toString()));
    }
  }
}
