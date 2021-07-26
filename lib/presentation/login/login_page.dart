import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_model.dart';

class LoginPage extends StatelessWidget {
  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Consumer<LoginModel>(builder: (context, model, child) {
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
                    await model.login();
                    _showDialog(context, 'ログインが完了しました');
                  } catch (e) {
                    _showDialog(context, e.toString());
                  }
                },
                child: Text('ログイン'),
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
