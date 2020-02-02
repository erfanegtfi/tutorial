// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$User on UserBase, Store {
  final _$languageAtom = Atom(name: 'UserBase.language');

  @override
  Language get language {
    _$languageAtom.context.enforceReadPolicy(_$languageAtom);
    _$languageAtom.reportObserved();
    return super.language;
  }

  @override
  set language(Language value) {
    _$languageAtom.context.conditionallyRunInAction(() {
      super.language = value;
      _$languageAtom.reportChanged();
    }, _$languageAtom, name: '${_$languageAtom.name}_set');
  }

  final _$stateAtom = Atom(name: 'UserBase.state');

  @override
  LoadingState get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(LoadingState value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$verifyUserAsyncAction = AsyncAction('verifyUser');

  @override
  Future<VerfyResponse> verifyUser(String code) {
    return _$verifyUserAsyncAction.run(() => super.verifyUser(code));
  }

  final _$loginAsyncAction = AsyncAction('login');

  @override
  Future<LoginResponse> login(String email) {
    return _$loginAsyncAction.run(() => super.login(email));
  }

  final _$updateUserProfileAsyncAction = AsyncAction('updateUserProfile');

  @override
  Future<ProfileResponse> updateUserProfile(
      String fullName, String languageId, String id) {
    return _$updateUserProfileAsyncAction
        .run(() => super.updateUserProfile(fullName, languageId, id));
  }
}
