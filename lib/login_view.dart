import 'package:esercizio_flutter/bloc/auth/auth_repository.dart';
import 'package:esercizio_flutter/bloc/auth/form_submission_status.dart';
import 'package:esercizio_flutter/bloc/auth/login/login_bloc.dart';
import 'package:esercizio_flutter/bloc/auth/login/login_event.dart';
import 'package:esercizio_flutter/bloc/auth/login/login_state.dart';
import 'package:esercizio_flutter/palette_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _snackBar(context, formStatus.exception.toString());
            context.read<LoginBloc>().add(
                LoginIntialFromStatus()
              );
          }
          if (formStatus is SubmissionSuccess) {
            Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => PaletteView()),
          (route) => false);
          }
        },
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    _emailField(),
                    _passwordField(),
                    _loginButton()
                  ]),
            )));
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: TextFormField(
          decoration: const InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'email',
          ),
          validator: (value) =>
              state.isValidEmail ? null : 'Username is too short',
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginEmailChange(email: value),
              ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.security),
                    hintText: 'Password',
                  ),
                  validator: (value) => state.isValidPassword
                      ? null
                      : 'Password is too short', // Sostituire con snakbar
                  onChanged: (value) => context
                      .read<LoginBloc>()
                      .add(LoginPasswordChange(password: value))),
            ));
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(40.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginSubmitted(
                              email: state.email, password: state.password));
                        }
                      },
                      child: const Text('Login')),
                ),
              ));
  }

  void _snackBar(BuildContext context, String message) {
    final snakBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snakBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) =>
                LoginBloc(authRepo: context.read<AuthRepository>()),
            child: _loginForm()));
  }
}
