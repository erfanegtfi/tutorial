// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$User on UserBase, Store {
  final _$languageNameAtom = Atom(name: 'UserBase.languageName');

  @override
  String get languageName {
    _$languageNameAtom.context.enforceReadPolicy(_$languageNameAtom);
    _$languageNameAtom.reportObserved();
    return super.languageName;
  }

  @override
  set languageName(String value) {
    _$languageNameAtom.context.conditionallyRunInAction(() {
      super.languageName = value;
      _$languageNameAtom.reportChanged();
    }, _$languageNameAtom, name: '${_$languageNameAtom.name}_set');
  }
}
