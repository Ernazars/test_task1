import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task1/domain/interactors/authorization_interactor.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

part 'authorization_cubit.freezed.dart';

@injectable
class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit(this._authorizationInteractor, this._appRouter)
      : super(const AuthorizationState.initial());

  final AuthorizationInteractor _authorizationInteractor;
  final AppRouter _appRouter;

  login({required String email, required String password}) async {
    emit(const AuthorizationState.authorization());
    var result =
        await _authorizationInteractor.login(email: email, password: password);
    result.fold(
      (error) => emit(AuthorizationState.failed(error.message)),
      (_) => _appRouter.pushAndPopUntil(
        const MainRoute(),
        predicate: (route) => false,
      ),
    );
  }

  toReg(){
    _appRouter.push(RegistrationRoute());
  }
}

@freezed
class AuthorizationState with _$AuthorizationState {
  const factory AuthorizationState.initial() = _Initial;
  const factory AuthorizationState.authorization() = _Authorization;
  const factory AuthorizationState.failed(String message) = _Failed;
}
