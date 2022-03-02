import 'package:esercizio_flutter/bloc/auth/auth_repository.dart';
import 'package:esercizio_flutter/bloc/auth/login/login_event.dart';
import 'package:esercizio_flutter/bloc/auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:esercizio_flutter/bloc/auth/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository authRepo;

  LoginBloc({required this.authRepo}) : super(LoginState()){
    // Resetto formStatus a IntialFormStatus
    on<LoginIntialFromStatus>((event, emit){
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    });
    // Aggiorna lo stato di email
    on<LoginEmailChange>((event, emit) async {
      emit(state.copyWith(email: event.email));
    });
    // Aggiorna lo stato di email
    on<LoginPasswordChange>((event, emit) async {
       emit(state.copyWith(password: event.password));

    });
    // Invio richiesta di login
    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try{
        var token = await authRepo.login(event.email, event.password);
        if(token == ''){
          emit(state.copyWith(formStatus: SubmissionFailed('Login Failed')));
        } else {
          emit(state.copyWith(formStatus: SubmissionSuccess(), token: token));
        }
      } catch(e) {
        emit(state.copyWith(formStatus: SubmissionFailed('Login Failed')));
      }
    });

}
}