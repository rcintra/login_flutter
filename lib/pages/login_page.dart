import 'package:login_flutter/domain/login_service.dart';
import 'package:login_flutter/utils/alerts.dart';
import 'package:login_flutter/utils/nav.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tlogin = TextEditingController();
  final _tsenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(padding: EdgeInsets.all(16),
      child: _body(context),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o login";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    return null;
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            validator: _validateLogin,
            controller: _tlogin,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.blue, fontSize: 25            ),
            decoration: InputDecoration(
              labelText: "Login",
              labelStyle: TextStyle(color: Colors.black, fontSize: 25,              ),
              hintText: "Digite o seu login",
              hintStyle: TextStyle(color: Colors.black, fontSize: 18              )
            ),
          ),
          TextFormField(
            validator: _validateSenha,
            controller: _tsenha,
            obscureText: true,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.blue, fontSize: 25            ),
            decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: Colors.black, fontSize: 25,              ),
                hintText: "Digite a sua senha",
                hintStyle: TextStyle(color: Colors.black, fontSize: 18              )
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20),
            child: RaisedButton(
              color: Colors.blue,
                child: _progress
                  ?
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                onPressed: () { _onClickLogin(context); } ),
          )
        ],
      ),
    );
  }

  void _onClickLogin(BuildContext context) async {
    final login = _tlogin.text;
    final senha = _tsenha.text;

    //if (!_formKey.currentState.validate()) {
    //  return;
    //}

    print("Login: $login, senha: $senha");

    setState(() {
      _progress = true;
    });

    final response = await LoginService.login(login, senha);

    if (response.isOk()) {
      push(context, HomePage());
    } else {
      alert(context, "Erro", response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

}
