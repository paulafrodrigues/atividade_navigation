import 'package:atividade_navigation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../models/user_model.dart';
import '../utils/password_validator.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final RegExp nameRegExp = RegExp('[a-zA-Z]');

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = LoginController();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Informe seu primeiro nome.',
                    labelText: 'Nome',
                    icon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !nameRegExp.hasMatch(value)) {
                      return 'Informe um nome válido!';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Preencha corretamente o e-mail',
                    labelText: 'Email',
                    icon: const Icon(Icons.mail_outline),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !EmailValidator.validate(value)) {
                      return 'Preencha corretamente o e-mail';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Password',
                      icon: const Icon(Icons.password)),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor informe a senha';
                    } else {
                      bool result = validatePassword(value);
                      if (result) {
                        return null;
                      } else {
                        return 'A senha deve ter no mínimo 8 dígitos e conter letra maiúscula, letra minuscula, número e caractere especial';
                      }
                    }
                  },
                ),
              ),
              ElevatedButton(onPressed: _formKey.currentState?.validate() == true ? () {
                showDialog(
                  context: context,
                  builder: (context) => const Center(child: CircularProgressIndicator(),
                  ),
                );
                final user = UserModel(
                  name: nameTextController.text,
                  email: emailTextController.text,
                  password: passwordTextController.text,
                );
                controller
                .login(user: user,)
                .then((value) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(user: user,
                  ),
                  ));
                });
              }
              : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff3e3e3c),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(80, 80))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Logar'),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.navigate_next_rounded)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
