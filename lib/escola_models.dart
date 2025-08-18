abstract class Avaliavel {
  double calcularMedia();
}

abstract class Pessoa {
  String nome;
  String cpf;

  Pessoa(this.nome, this.cpf);
}

class Aluno extends Pessoa {
  String matricula;
  String curso;

  Aluno(String nome, String cpf, this.matricula, this.curso) : super(nome, cpf);
}

class Professor extends Pessoa {
  int cargaHoraria;

  Professor({
    required String nome,
    required String cpf,
    required this.cargaHoraria,
  }) : super(nome, cpf);
}

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

class Turma implements Avaliavel {
  Disciplina disciplina;

  List<Aluno> _alunos;
  List<List<double>> _notas;
  List<List<int>> _faltas;

  List<Aluno> get alunos => _alunos;
  List<List<double>> get notas => _notas;
  List<List<int>> get faltas => _faltas;

  Turma({
    required this.disciplina,
  })  : _alunos = [],
        _notas = [],
        _faltas = [];


  void adicionarAluno(Aluno aluno) {
    _alunos.add(aluno);
    _notas.add([]);
    _faltas.add([]);
  }

  void adicionarNota(int indiceAluno, double nota) {
    if (indiceAluno >= 0 && indiceAluno < _notas.length) {
      _notas[indiceAluno].add(nota);
    }
  }

  double calcularMediaAluno(int indiceAluno) {
    if (indiceAluno < 0 ||
        indiceAluno >= _notas.length ||
        _notas[indiceAluno].isEmpty) return 0.0;
    return _notas[indiceAluno].reduce((a, b) => a + b) /
        _notas[indiceAluno].length;
  }

  void adicionarFalta(int indiceAluno, int quantidade) {
    if (indiceAluno >= 0 && indiceAluno < _faltas.length) {
      _faltas[indiceAluno].add(quantidade);
    }
  }

  int calcularTotalFaltas(int indiceAluno) {
    if (indiceAluno < 0 ||
        indiceAluno >= _faltas.length ||
        _faltas[indiceAluno].isEmpty) return 0;
    return _faltas[indiceAluno].reduce((a, b) => a + b);
  }

  @override
  double calcularMedia() {
    if (_alunos.isEmpty) return 0.0;
    return _alunos.asMap().keys
        .map(calcularMediaAluno)
        .reduce((a, b) => a + b) /
        _alunos.length;
  }
}