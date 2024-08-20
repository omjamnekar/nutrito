import 'package:equatable/equatable.dart';

abstract class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final Map<String, dynamic> data;

  DataLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DataError extends DataState {
  final String message;

  DataError(this.message);

  @override
  List<Object> get props => [message];
}

// Add the DataFetchFailed class
class DataFetchFailed extends DataState {
  final String error;

  DataFetchFailed(this.error);

  @override
  List<Object> get props => [error];
}

class DataFetched extends DataState {
  final Map<String, dynamic> initialData;
  final Map<String, dynamic> ratioData;
  final Map<String, dynamic> healthData;
  final Map<String, dynamic> conclusionData;

  DataFetched(
    this.initialData,
    this.ratioData,
    this.healthData,
    this.conclusionData,
  );

  @override
  List<Object> get props => [
        initialData,
        ratioData,
        healthData,
        conclusionData,
      ];
}
