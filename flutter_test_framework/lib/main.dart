import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorText = '';
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', key: ValueKey('LoginTitle')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  key: const ValueKey('cpf'),
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'CPF'),
                ),
               TextField(
                  key: const ValueKey('password'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: _showError,
                child: Text(
                  _errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Semantics(
                label: 'Entrar', // Insira o rótulo semântico desejado aqui
                child: ElevatedButton(
                  key: const ValueKey('loginButton'),
                  onPressed: () {
                    final cpf = _cpfController.text;
                    final password = _passwordController.text;

                    if (cpf == '27696205099' && password == '1234') {
                      // Login bem-sucedido, navegue para a segunda tela.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessPage(),
                        ),
                      );
                    } else {
                      setState(() {
                        _errorText = 'CPF ou senha incorretos.';
                        _showError = true;
                      });
                    }
                  },
                  child: const Icon(Icons.login),
                ),
              ),
              Semantics(
                label: 'Limpar campos',
                child: ElevatedButton(
                  key: const ValueKey('clearButton'),
                  onPressed: () {
                    // Limpar campos
                    _cpfController.clear();
                    _passwordController.clear();
                    setState(() {
                      _errorText = '';
                      _showError = false;
                    });
                  },
                  child: const Icon(Icons.clear),
                ),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Esqueci a Senha',
                          key: ValueKey('TitleEsqueciSenha'),
                        ),
                        content: const Text(
                            'Entre em contato com o administrador para redefinir sua senha.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Fechar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'Esqueci a senha',
                  key: ValueKey('esqueciSenha'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Efetuado com Sucesso',
            key: ValueKey('LoginEfetuado')),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout,
                key: ValueKey('logoutButton'), semanticLabel: 'Sair'),
            onPressed: () {
              // Navegue de volta à tela de login.
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: const Center(
        key: ValueKey('contentTextSucessLogin'),
        child: Text('Bem-vindo à sua conta!'),
      ),
    );
  }
}
