import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_application/models/pokemon_details_model.dart';
import 'package:pokemon_application/models/pokemon_list_item_model.dart';

class ApiService {
  static Future<List<PokemonListItemModel>> fetchPokemonList() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> results = data['results'];
      List<PokemonListItemModel> pokemonList = [];
      for (var item in results) {
        pokemonList.add(PokemonListItemModel.fromJson(item));
      }
      return pokemonList;
    } else {
      throw Exception('Erorr');
    }
  }

  static Future<PokemonDetailsModel> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final int id = data['id'];
      final String name = data['name'];
      final List<dynamic> types = data['types'];
      List<String> typeNames = [];
      for (var type in types) {
        typeNames.add(type['type']['name']);
      }
      final int weight = data['weight'];
      final int height = data['height'];
      final String frontImageUrl = data['sprites']['front_default'] ?? '';
      return PokemonDetailsModel(
        id: id,
        name: name,
        type: typeNames,
        weight: weight,
        height: height,
        frontImageUrl: frontImageUrl,
      );
    } else {
      throw Exception('Errorr');
    }
  }
}
