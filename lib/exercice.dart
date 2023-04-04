class Exercice {
  final String nom;
  final int? repetitions;
  Duration? duree;
  final String icone;
  final String video;

  Exercice({
    required this.nom,
    this.repetitions,
    this.duree,
    required this.icone,
    required this.video,
  }) {
    assert(
    (repetitions != null && duree == null) || (repetitions == null && duree != null),
    'Un exercice doit avoir soit des répétitions, soit une durée, mais pas les deux.',
    );
  }
}
