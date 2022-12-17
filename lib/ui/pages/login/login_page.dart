import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        presenter.isLoadingStream.listen((isLoading) {
          if (isLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              child: SimpleDialog(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text('Aguarde...', textAlign: TextAlign.center),
                    ],
                  )
                ],
              ),
            );
          }
        });

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoginHeader(),
              Headline1(
                text: 'Login',
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  child: Column(
                    children: [
                      StreamBuilder<String>(
                          stream: presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                errorText: snapshot.data?.isEmpty == true
                                    ? null
                                    : snapshot.data,
                                icon: Icon(
                                  Icons.email,
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: presenter.validateEmail,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 32),
                        child: StreamBuilder<String>(
                            stream: presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  errorText: snapshot.data?.isEmpty == true
                                      ? null
                                      : snapshot.data,
                                  icon: Icon(
                                    Icons.lock,
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                obscureText: true,
                                onChanged: presenter.validatePassword,
                              );
                            }),
                      ),
                      StreamBuilder<bool>(
                          stream: presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              onPressed:
                                  snapshot.data == true ? presenter.auth : null,
                              child: Text('Entrar'.toUpperCase()),
                            );
                          }),
                      FlatButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                          label: Text('Criar conta')),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}