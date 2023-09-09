import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test_framework/main.dart';

void main() {
  testWidgets('Teste de login bem-sucedido', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verifique se a página de login está sendo exibida inicialmente.
    expect(find.text('Login'), findsOneWidget);

    // Preencha o campo CPF e senha e clique no botão de login.
    await tester.enterText(
        find.byKey(const ValueKey('cpf_key')), '27696205099');
    await tester.enterText(find.byKey(const ValueKey('password_key')), '1234');
    await tester.tap(find.byKey(const ValueKey('login_button')));

    // Aguarde a navegação para a página de sucesso.
    await tester.pumpAndSettle();

    // Verifique se a página de sucesso está sendo exibida.
    expect(find.text('Login Efetuado com Sucesso'), findsOneWidget);
  });

  testWidgets('Teste de login com erro', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Preencha o campo CPF e senha com informações de login incorretas.
    await tester.enterText(find.byKey(const ValueKey('cpf_key')), '123456789');
    await tester.enterText(
        find.byKey(const ValueKey('password_key')), 'senha_incorreta');
    await tester.tap(find.byKey(const ValueKey('login_button')));

    // Aguarde a exibição do erro.
    await tester.pumpAndSettle();

    // Verifique se a mensagem de erro está sendo exibida.
    expect(find.text('CPF ou senha incorretos.'), findsOneWidget);
  });

  testWidgets('Teste de limpar campos', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Preencha o campo CPF e senha.
    await tester.enterText(
        find.byKey(const ValueKey('cpf_key')), '27696205099');
    await tester.enterText(find.byKey(const ValueKey('password_key')), '1234');

    // Clique no botão de limpar campos.
    await tester.tap(find.byKey(const ValueKey('clear_button')));

    // Aguarde a limpeza dos campos.
    await tester.pumpAndSettle();

    // Verifique se os campos estão vazios.
    expect(find.text('27696205099'), findsNothing);
    expect(find.text('1234'), findsNothing);
  });

  testWidgets('Teste de esqueci a senha', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Clique no botão "Esqueci a senha".
    await tester.tap(find.byKey(const ValueKey('forgot_password')));

    // Aguarde a exibição do diálogo.
    await tester.pumpAndSettle();

    // Verifique se o diálogo está sendo exibido.
    expect(find.text('Esqueci a Senha'), findsOneWidget);
    expect(
        find.text(
            'Entre em contato com o administrador para redefinir sua senha.'),
        findsOneWidget);
  });
}
