import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/interactors/registration_interactor.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

part 'registration_cubit.freezed.dart';

@injectable
class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationInteractor _registrationInteractor;
  final AppRouter _appRouter;
  RegistrationCubit(this._registrationInteractor, this._appRouter)
      : super(const RegistrationState.initial());

  toRegistration({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const RegistrationState.registration());
    var isRegistered = await _registrationInteractor.toRegistration(
        user: UserEntity(
            email: email,
            name: name,
            password: password,
            regDate: DateTime.now().millisecondsSinceEpoch));
    isRegistered.fold(
        (error) => emit(RegistrationState.failed(error.message)),
        (_) => _appRouter.pushAndPopUntil(
              const MainRoute(),
              predicate: (route) => false,
            ));
  }
}

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = _Initial;
  const factory RegistrationState.registration() = _Registration;
  const factory RegistrationState.failed(String message) = _Failed;
}
