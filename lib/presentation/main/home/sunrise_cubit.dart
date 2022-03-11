import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/domain/entities/sunrise_entity.dart';
import 'package:test_task1/domain/interactors/sunrise_interactor.dart';

part 'sunrise_cubit.freezed.dart';

@injectable
class SunriseCubit extends Cubit<SunriseState> {
  SunriseCubit(this._sunriseInteractor) : super(const SunriseState.loading()) {
    fetchData();
  }

  final SunriseInteractor _sunriseInteractor;

  fetchData() async {
    emit(SunriseState.loading());
    var result = await _sunriseInteractor.fetchData();
    emit(result.fold((error) => SunriseState.failed(error.message),
        (data) => SunriseState.sunrise(data)));
  }
}

@freezed
class SunriseState with _$SunriseState {
  const factory SunriseState.loading() = _Loading;
  const factory SunriseState.sunrise(SunriseEntity data) = _Sunrise;
  const factory SunriseState.failed(String message) = _Failed;
}
