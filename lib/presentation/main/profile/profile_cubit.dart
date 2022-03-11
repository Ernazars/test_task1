import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/domain/entities/user_entity.dart';
import 'package:test_task1/domain/interactors/authorization_interactor.dart';
import 'package:test_task1/domain/interactors/session_interactor.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

part 'profile_cubit.freezed.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
      this._sessionInteractor, this._authorizationInteractor, this._appRouter)
      : super(const ProfileState.initial()) {
    _sessionInteractor.getActiveUser().then(
          (result) => emit(
            result.fold(
              (error) => ProfileState.failed(error.message),
              (user) {
                if (user != null) {
                  return ProfileState.data(user);
                } else {
                  return const ProfileState.failed("Не удалось получить данные");
                }
              },
            ),
          ),
        );
  }

  final SessionInteractor _sessionInteractor;
  final AuthorizationInteractor _authorizationInteractor;
  final AppRouter _appRouter;

  logout() async {
    var reuslt = await _authorizationInteractor.logout();
    reuslt.fold(
        (error) => emit(ProfileState.logoutFailed(error.message)),
        (_) => _appRouter.pushAndPopUntil(
              const SplashRoute(),
              predicate: (route) => false,
            ));
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.data(UserEntity user) = _Data;
  const factory ProfileState.failed(String message) = _Failed;
  const factory ProfileState.logoutFailed(String message) = _LogoutFailed;
}
