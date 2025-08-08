import 'package:flutter/material.dart';
import 'escola_models.dart';

class FormularioAlunoScreen extends StatefulWidget {
  const FormularioAlunoScreen({super.key});

  @override
  State<FormularioAlunoScreen> createState() => _FormularioAlunoScreenState();
}

class _FormularioAlunoScreenState extends State<FormularioAlunoScreen> {
  // Controllers para pegar o texto dos campos do formulário
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _cursoController = TextEditingController();

  // Função para criar o objeto Aluno e retorná-lo para a tela anterior
  void _salvarFormulario() {
    final novoAluno = Aluno(
      _nomeController.text,
      _cpfController.text,
      _matriculaController.text,
      _cursoController.text,
    );
    // 'Navigator.pop' fecha a tela atual e envia 'novoAluno' como resultado
    Navigator.pop(context, novoAluno);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Novo Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome Completo'),
            ),
            TextField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(labelText: 'Matrícula'),
            ),
            TextField(
              controller: _cursoController,
              decoration: const InputDecoration(labelText: 'Curso'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarFormulario,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}