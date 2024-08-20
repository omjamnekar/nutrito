import 'package:equatable/equatable.dart';

abstract class DataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchInitialData extends DataEvent {}

class FetchRatioData extends DataEvent {}

class FetchHealthData extends DataEvent {}

class FetchConclusionData extends DataEvent {}
