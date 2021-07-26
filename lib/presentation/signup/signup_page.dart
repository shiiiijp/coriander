import 'package:coriander/presentation/signup/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Consumer<SignUpModel>(builder: (context, model, child) {
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: ' email@example.com'),
                controller: mailController,
                onChanged: (text) {
                  model.mail = text;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: ' password'),
                obscureText: true,
                controller: passwordController,
                onChanged: (text) {
                  model.password = text;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await model.signUp();
                    _showDialog(context, '登録が完了しました');
                  } catch (e) {
                    _showDialog(context, e.toString());
                  }
                },
                child: Text('登録する'),
              )
            ],
          );
        }),
      ),
    );
  }

  Future _showDialog(
    BuildContext context,
    String title,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
