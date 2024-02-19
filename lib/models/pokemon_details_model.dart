class PokemonDetailsModel {
  final int id;
  final String name;
  final List<String> type;
  final int weight;
  final int height;
  final String frontImageUrl;

  PokemonDetailsModel({
    required this.frontImageUrl,
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    required this.type,
  });
}
