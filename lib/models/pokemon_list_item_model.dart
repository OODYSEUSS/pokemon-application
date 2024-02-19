class PokemonListItemModel {
  final String name;
  final String url;

  PokemonListItemModel({required this.name, required this.url});

  factory PokemonListItemModel.fromJson(Map<String, dynamic> json) {
    return PokemonListItemModel(
      name: json['name'],
      url: json['url'],
    );
  }
}
