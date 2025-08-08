// Arquivo: lib/formulario_turma_screen.dart

import 'package:flutter/material.dart';
import 'escola_models.dart';

class FormularioTurmaScreen extends StatefulWidget {
  const FormularioTurmaScreen({super.key});

  @override
  State<FormularioTurmaScreen> createState() => _FormularioTurmaScreenState();
}

class _FormularioTurmaScreenState extends State<FormularioTurmaScreen> {
  final _nomeDisciplinaController = TextEditingController();
  final _codigoDisciplinaController = TextEditingController();
  final _nomeProfessorController = TextEditingController();
  final _cpfProfessorController = TextEditingController();
  final _cargaHorariaController = TextEditingController();

  void _salvarTurma() {
    // Cria o Professor primeiro
    final novoProfessor = Professor(
      nome: _nomeProfessorController.text,
      cpf: _cpfProfessorController.text,
      cargaHoraria: int.tryParse(_cargaHorariaController.text) ?? 0,
    );

    // Cria a Disciplina, associando o professor a ela
    final novaDisciplina = Disciplina(
      nome: _nomeDisciplinaController.text,
      codigo: _codigoDisciplinaController.text,
      professor: novoProfessor,
    );

    // Cria a Turma, associando a disciplina a ela
    final novaTurma = Turma(disciplina: novaDisciplina);

    Navigator.pop(context, novaTurma);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Nova Turma'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Dados da Disciplina', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nomeDisciplinaController,
              decoration: const InputDecoration(labelText: 'Nome da Disciplina'),
            ),
            TextField(
              controller: _codigoDisciplinaController,
              decoration: const InputDecoration(labelText: 'Código da Disciplina'),
            ),
            const SizedBox(height: 24),
            const Text('Dados do Professor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _nomeProfessorController,
              decoration: const InputDecoration(labelText: 'Nome do Professor'),
            ),
            TextField(
              controller: _cpfProfessorController,
              decoration: const InputDecoration(labelText: 'CPF do Professor'),
            ),
            TextField(
              controller: _cargaHorariaController,
              decoration: const InputDecoration(labelText: 'Carga Horária (em horas)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarTurma,
              child: const Text('Criar e Salvar Turma'),
            )
          ],
        ),
      ),
    );
  }
}