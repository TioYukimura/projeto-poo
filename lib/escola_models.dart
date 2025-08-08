// Arquivo: lib/escola_models.dart

// 1. Interface 'Avaliavel' foi adicionada
abstract class Avaliavel {
  double calcularMedia();
}

// 2. Classe 'Pessoa' continua igual
abstract class Pessoa {
  String nome;
  String cpf;

  Pessoa(this.nome, this.cpf);
}

// 3. Classe 'Aluno' continua igual
class Aluno extends Pessoa {
  String matricula;
  String curso;

  Aluno(String nome, String cpf, this.matricula, this.curso) : super(nome, cpf);
}

// 4. Classe 'Professor' foi ajustada para ter cargaHoraria
class Professor extends Pessoa {
  int cargaHoraria;

  Professor({
    required String nome,
    required String cpf,
    required this.cargaHoraria,
  }) : super(nome, cpf);
}

// 5. Classe 'Disciplina' foi criada
class Disciplina {
  String nome;
  String codigo;
  Professor professor;

  Disciplina({
    required this.nome,
    required this.codigo,
    required this.professor,
  });
}

// 6. Classe 'Turma' foi ajustada para implementar 'Avaliavel' e conter uma 'Disciplina'
class Turma implements Avaliavel {
  Disciplina disciplina;
  List<Aluno> alunos;
  List<List<double>> notas;
  List<List<int>> faltas;

  Turma({
    required this.disciplina,
  }) : alunos = [],
        notas = [],
        faltas = [];

  void adicionarAluno(Aluno aluno) {
    alunos.add(aluno);
    notas.add([]);
    faltas.add([]);
  }

  void adicionarNota(int indiceAluno, double nota) {
    if (indiceAluno >= 0 && indiceAluno < notas.length) {
      notas[indiceAluno].add(nota);
    }
  }

  double calcularMediaAluno(int indiceAluno) {
    if (indiceAluno >= 0 && indiceAluno < notas.length) {
      List<double> notasDoAluno = notas[indiceAluno];
      if (notasDoAluno.isEmpty) return 0.0;
      return notasDoAluno.reduce((a, b) => a + b) / notasDoAluno.length;
    }
    return 0.0;
  }

  void adicionarFalta(int indiceAluno, int quantidade) {
    if (indiceAluno >= 0 && indiceAluno < faltas.length) {
      faltas[indiceAluno].add(quantidade);
    }
  }

  int calcularTotalFaltas(int indiceAluno) {
    if (indiceAluno >= 0 && indiceAluno < faltas.length) {
      List<int> faltasDoAluno = faltas[indiceAluno];
      if (faltasDoAluno.isEmpty) return 0;
      return faltasDoAluno.reduce((a, b) => a + b);
    }
    return 0;
  }

  // Implementação do método da interface Avaliavel
  @override
  double calcularMedia() {
    if (alunos.isEmpty) {
      return 0.0;
    }
    double somaDasMedias = 0.0;
    for (int i = 0; i < alunos.length; i++) {
      somaDasMedias += calcularMediaAluno(i);
    }
    return somaDasMedias / alunos.length;
  }
}