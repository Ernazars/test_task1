import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task1/core/pref_keys.dart';
import 'package:test_task1/domain/interactors/session_interactor.dart';
import 'package:test_task1/injection/init_get.dart';
import 'package:test_task1/navigation/app_router.gr.dart';

part 'splash_cubit.freezed.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SessionInteractor _sessionInteractor;
  final AppRouter _appRouter;
  final pref = getIt<SharedPreferences>();

  SplashCubit(
    this._appRouter,
    this._sessionInteractor,
  ) : super(const SplashState.init()) {
    Timer(const Duration(seconds: 2), () {
      _checkSession();
    });
  }

  _checkSession() async {
    var session = await _sessionInteractor.getActiveUser();
    session.fold((_) => _appRouter.pushAndPopUntil(RegistrationRoute(), predicate: (_)=>false), (user) async {
      if (user != null) {
        _appRouter.pushAndPopUntil(const MainRoute(), predicate: (_)=>false);
      } else {
        var haveUsers = await _sessionInteractor.haveUsers();
        haveUsers.fold(
          (_) => _appRouter.pushAndPopUntil(RegistrationRoute(), predicate: (_)=>false),
          (haveUsers) => haveUsers
              ? _appRouter.pushAndPopUntil(AuthorizationRoute(
                  email: getIt<SharedPreferences>()
                          .getString(PrefKeys.lastActiveUser) ??
                      ""), predicate: (_)=>false)
              : _appRouter.pushAndPopUntil(RegistrationRoute(), predicate: (_)=>false),
        );
      }
    });
  }
}

@freezed
class SplashState with _$SplashState {
  const factory SplashState.init() = _Init;
}
