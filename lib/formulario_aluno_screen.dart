import 'package:flutter/material.dart';
import 'escola_models.dart';

class FormularioAlunoScreen extends StatefulWidget {
  const FormularioAlunoScreen({super.key});

  @override
  State<FormularioAlunoScreen> createState() => _FormularioAlunoScreenState();
}

class _FormularioAlunoScreenState extends State<FormularioAlunoScreen> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _cursoController = TextEditingController();

  void _salvarFormulario() {
    final novoAluno = Aluno(
      _nomeController.text,
      _cpfController.text,
      _matriculaController.text,
      _cursoController.text,
    );
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