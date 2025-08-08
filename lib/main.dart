// Arquivo: lib/main.dart

import 'package:flutter/material.dart';
import 'escola_models.dart';
import 'formulario_aluno_screen.dart';
import 'formulario_turma_screen.dart';

void main() {
  runApp(const SistemaEscolarApp());
}

class SistemaEscolarApp extends StatelessWidget {
  const SistemaEscolarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Escolar',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TurmaScreen(),
    );
  }
}

class TurmaScreen extends StatefulWidget {
  const TurmaScreen({super.key});

  @override
  State<TurmaScreen> createState() => _TurmaScreenState();
}

class _TurmaScreenState extends State<TurmaScreen> {
  Turma? _turma;

  void _criarNovaTurma() async {
    final novaTurma = await Navigator.push<Turma>(context,
      MaterialPageRoute(builder: (context) => const FormularioTurmaScreen()),
    );
    if (novaTurma != null) setState(() => _turma = novaTurma);
  }

  void _adicionarAluno() async {
    final novoAluno = await Navigator.push<Aluno>(context,
      MaterialPageRoute(builder: (context) => const FormularioAlunoScreen()),
    );
    if (novoAluno != null) setState(() => _turma?.adicionarAluno(novoAluno));
  }

  void _mostrarDialogoAdicionarNota(int indiceAluno) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Adicionar Nota para ${_turma!.alunos[indiceAluno].nome}'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Nota (ex: 8.5)'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final double? nota = double.tryParse(controller.text);
              if (nota != null) {
                setState(() => _turma!.adicionarNota(indiceAluno, nota));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDialogoAdicionarFalta(int indiceAluno) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lançar Faltas para ${_turma!.alunos[indiceAluno].nome}'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Quantidade de Faltas'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              final int? faltas = int.tryParse(controller.text);
              if (faltas != null) {
                setState(() => _turma!.adicionarFalta(indiceAluno, faltas));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Usando uma variável local para o tema para fácil acesso às cores
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_turma == null ? 'Gerenciador de Turma' : 'Turma da Disciplina: ${_turma!.disciplina.nome}'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: _turma == null
          ? _buildTelaCriarTurma()
          : _buildTelaDetalhesTurma(),
      floatingActionButton: _turma == null
          ? null
          : FloatingActionButton(
        onPressed: _adicionarAluno,
        tooltip: 'Adicionar Aluno',
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildTelaCriarTurma() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Nenhuma turma cadastrada.', style: TextStyle(fontSize: 22)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Criar Nova Turma'),
            onPressed: _criarNovaTurma,
          ),
        ],
      ),
    );
  }

  Widget _buildTelaDetalhesTurma() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Disciplina: ${_turma!.disciplina.nome} (${_turma!.disciplina.codigo})', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Professor(a): ${_turma!.disciplina.professor.nome}'),
                Text('Carga Horária: ${_turma!.disciplina.professor.cargaHoraria} horas'),
                const SizedBox(height: 8),
                // Exibe a média geral da turma, usando o método da interface!
                Text('Média Geral da Turma: ${_turma!.calcularMedia().toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text('Alunos Matriculados:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _turma!.alunos.length,
            itemBuilder: (context, index) {
              final aluno = _turma!.alunos[index];
              final notasDoAluno = _turma!.notas[index];
              final mediaDoAluno = _turma!.calcularMediaAluno(index);
              final totalDeFaltas = _turma!.calcularTotalFaltas(index);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(child: Text(aluno.nome.substring(0, 1))),
                  title: Text(aluno.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Matrícula: ${aluno.matricula}'),
                      Text('Notas: ${notasDoAluno.isEmpty ? "N/A" : notasDoAluno.join(", ")}'),
                      Text('Faltas: $totalDeFaltas', style: TextStyle(color: totalDeFaltas > 0 ? Colors.red.shade700 : null)),
                      Text(
                        'Média: ${mediaDoAluno.toStringAsFixed(1)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        color: Colors.green,
                        tooltip: "Adicionar Nota",
                        onPressed: () => _mostrarDialogoAdicionarNota(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.event_busy),
                        color: Colors.orange,
                        tooltip: "Lançar Faltas",
                        onPressed: () => _mostrarDialogoAdicionarFalta(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}