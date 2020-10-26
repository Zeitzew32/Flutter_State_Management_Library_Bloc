part of 'stats_bloc.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsLoadInProgress extends StatsState {}

class StatsLoadSuccess extends StatsState {
  final int numActive;
  final int numComplete;

  const StatsLoadSuccess(this.numActive, this.numComplete);

  @override
  List<Object> get props => [numActive, numComplete];

  @override
  String toString() {
    return 'StatsLoadSuccess { numActive: $numActive, numComplete: $numComplete}';
  }
}
