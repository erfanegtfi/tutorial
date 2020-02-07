// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Course on CourseBase, Store {
  final _$loadingStateAtom = Atom(name: 'CourseBase.loadingState');

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

  final _$courseAtom = Atom(name: 'CourseBase.course');

  @override
  Course get course {
    _$courseAtom.context.enforceReadPolicy(_$courseAtom);
    _$courseAtom.reportObserved();
    return super.course;
  }

  @override
  set course(Course value) {
    _$courseAtom.context.conditionallyRunInAction(() {
      super.course = value;
      _$courseAtom.reportChanged();
    }, _$courseAtom, name: '${_$courseAtom.name}_set');
  }

  final _$_courseListAtom = Atom(name: 'CourseBase._courseList');

  @override
  ObservableList<Course> get _courseList {
    _$_courseListAtom.context.enforceReadPolicy(_$_courseListAtom);
    _$_courseListAtom.reportObserved();
    return super._courseList;
  }

  @override
  set _courseList(ObservableList<Course> value) {
    _$_courseListAtom.context.conditionallyRunInAction(() {
      super._courseList = value;
      _$_courseListAtom.reportChanged();
    }, _$_courseListAtom, name: '${_$_courseListAtom.name}_set');
  }

  final _$courseListErrorAtom = Atom(name: 'CourseBase.courseListError');

  @override
  Meta get courseListError {
    _$courseListErrorAtom.context.enforceReadPolicy(_$courseListErrorAtom);
    _$courseListErrorAtom.reportObserved();
    return super.courseListError;
  }

  @override
  set courseListError(Meta value) {
    _$courseListErrorAtom.context.conditionallyRunInAction(() {
      super.courseListError = value;
      _$courseListErrorAtom.reportChanged();
    }, _$courseListErrorAtom, name: '${_$courseListErrorAtom.name}_set');
  }

  final _$getCourseListAsyncAction = AsyncAction('getCourseList');

  @override
  Future<void> getCourseList() {
    return _$getCourseListAsyncAction.run(() => super.getCourseList());
  }

  final _$getCourseAsyncAction = AsyncAction('getCourse');

  @override
  Future<void> getCourse(int courseid) {
    return _$getCourseAsyncAction.run(() => super.getCourse(courseid));
  }
}
