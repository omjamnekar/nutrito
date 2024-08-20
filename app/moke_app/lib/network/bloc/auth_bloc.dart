import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:moke_app/network/auth.dart'; // Assuming you have a login method here

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final PromptBuilder promptBuilder;

  AuthBloc(this.promptBuilder) : super(AuthInitial()) {
    // Register the event handler for LoginRequested
    on<LoginRequested>((event, emit) async {
      try {
        emit(Authenticating());

        // Call the login method from your promptBuilder
        await promptBuilder.login(event.username, event.password);

        emit(Authenticated());
      } catch (e) {
        emit(AuthenticationFailed(e.toString()));
      }
    });
  }
}
