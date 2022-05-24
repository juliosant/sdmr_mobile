class Doador{
  final int id;
  final String first_name;
  final String last_name;
  double pontos_ranking;

  Doador({
    required this.id,
    required this.first_name,
    required this.last_name,
    this.pontos_ranking = 0.0,
  });
}