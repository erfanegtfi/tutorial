// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_course.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubCourse on SubCourseBase, Store {
  final _$loadingStateAtom = Atom(name: 'SubCourseBase.loadingState');

  @override
  LoadingState get loadingState {
    _$loadingStateAtom.context.enforceReadPolicy(_$loadingStateAtom);
    _$loadingStateAtom.reportObserved();
    return super.loadingState;
  }

  @override
  set loadingState(LoadingState value) {
    _$loadingStateAtom.context.conditionallyRunInAction(() {
      super.loadingState = value;
      _$loadingStateAtom.reportChanged();
    }, _$loadingStateAtom, name: '${_$loadingStateAtom.name}_set');
  }

  final _$_courseListAtom = Atom(name: 'SubCourseBase._courseList');

  @override
  ObservableList<SubCourse> get _courseList {
    _$_courseListAtom.context.enforceReadPolicy(_$_courseListAtom);
    _$_courseListAtom.reportObserved();
    return super._courseList;
  }

  @override
  set _courseList(ObservableList<SubCourse> value) {
    _$_courseListAtom.context.conditionallyRunInAction(() {
      super._courseList = value;
      _$_courseListAtom.reportChanged();
    }, _$_courseListAtom, name: '${_$_courseListAtom.name}_set');
  }

  final _$courseListErrorAtom = Atom(name: 'SubCourseBase.courseListError');

  @override
  DioError get courseListError {
    _$courseListErrorAtom.context.enforceReadPolicy(_$courseListErrorAtom);
    _$courseListErrorAtom.reportObserved();
    return super.courseListError;
  }

  @override
  set courseListError(DioError value) {
    _$courseListErrorAtom.context.conditionallyRunInAction(() {
      super.courseListError = value;
      _$courseListErrorAtom.reportChanged();
    }, _$courseListErrorAtom, name: '${_$courseListErrorAtom.name}_set');
  }

  final _$getCourseListAsyncAction = AsyncAction('getCourseList');

  @override
  Future<void> getCourseList(int id) {
    return _$getCourseListAsyncAction.run(() => super.getCourseList(id));
  }
}
