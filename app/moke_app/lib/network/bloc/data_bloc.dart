import 'package:bloc/bloc.dart';
import 'data_event.dart';
import 'data_state.dart';
import 'package:moke_app/network/auth.dart';
import 'package:moke_app/util/enums/Prompt.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final PromptBuilder promptBuilder;

  DataBloc(this.promptBuilder) : super(DataInitial()) {
    on<FetchInitialData>((event, emit) async {
      await _fetchData(
        emit,
        () => promptBuilder.promptExecution(
            (p0) => p0, PromptEvent.initialPrompt),
        initialData: true,
      );
    });

    on<FetchRatioData>((event, emit) async {
      await _fetchData(
        emit,
        () =>
            promptBuilder.promptExecution((p0) => p0, PromptEvent.ratioPrompt),
        ratioData: true,
      );
    });

    on<FetchHealthData>((event, emit) async {
      await _fetchData(
        emit,
        () =>
            promptBuilder.promptExecution((p0) => p0, PromptEvent.healthPrompt),
        healthData: true,
      );
    });

    on<FetchConclusionData>((event, emit) async {
      await _fetchData(
        emit,
        () => promptBuilder.promptExecution(
            (p0) => p0, PromptEvent.conclusionPrompt),
        conclusionData: true,
      );
    });
  }

  Future<void> _fetchData(
    Emitter<DataState> emit,
    Future<Map<String, dynamic>> Function() fetchData, {
    bool initialData = false,
    bool ratioData = false,
    bool healthData = false,
    bool conclusionData = false,
  }) async {
    try {
      emit(DataLoading());

      final currentState = state;
      Map<String, dynamic> initial = {};
      Map<String, dynamic> ratio = {};
      Map<String, dynamic> health = {};
      Map<String, dynamic> conclusion = {};

      // Preserve the previously loaded data if available
      if (currentState is DataFetched) {
        initial = currentState.initialData;
        ratio = currentState.ratioData;
        health = currentState.healthData;
        conclusion = currentState.conclusionData;
      }

      // Fetch the new data based on the event type
      final data = await fetchData();

      // Emit the state with the updated data, while preserving the rest
      emit(DataFetched(
        initialData ? data : initial,
        ratioData ? data : ratio,
        healthData ? data : health,
        conclusionData ? data : conclusion,
      ));
    } catch (e) {
      emit(DataFetchFailed(e.toString()));
    }
  }
}
