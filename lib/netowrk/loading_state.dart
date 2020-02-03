import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoadState extends Equatable {
  // LoadingState([List props = const []]);
}

// class InitialState extends LoadState {
//   @override
//   String toString() => 'InitialState';

//   @override
//   List<Object> get props => null;
// }

// class LoadingState extends LoadState {
//   @override
//   String toString() => 'LoadingState';

//   @override
//   List<Object> get props => null;
// }

// class LoadedState extends LoadState {
//   List objects;
//   dynamic object;
//   LoadedState({this.objects, this.object});

//   @override
//   String toString() => 'LoadedState';

//   @override
//   List<Object> get props => [object];
// }

// class FailureState extends LoadState {
//   final DioError error;

//   FailureState({@required this.error});

//   @override
//   String toString() => 'FailureState';

//   @override
//   List<Object> get props => [error];
// }
