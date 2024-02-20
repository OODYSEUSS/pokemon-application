import 'package:flutter/material.dart';
import 'package:pokemon_application/models/pokemon_list_item_model.dart';
import 'package:pokemon_application/models/pokemon_details_model.dart';
import 'package:pokemon_application/services/api_services.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final PokemonListItemModel pokemon;

  const PokemonDetailsScreen({Key? key, required this.pokemon})
      : super(key: key);

  @override
  _PokemonDetailsScreenState createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  late Future<PokemonDetailsModel> _pokemonDetails;

  @override
  void initState() {
    super.initState();
    _pokemonDetails = ApiService.fetchPokemonDetails(widget.pokemon.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(52, 102, 175, 1),
        title: const Text(
          'Details',
          style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1), fontSize: 30),
        ),
      ),
      body: FutureBuilder<PokemonDetailsModel>(
        future: _pokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pokemon = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('${pokemon.frontImageUrl}'),
                Text('Name: ${pokemon.name}'),
                Text('Type: ${pokemon.type.join(', ')}'),
                Text('Weight: ${pokemon.weight}'),
                Text('Height: ${pokemon.height}'),
              ],
            );
          }
        },
      ),
    );
  }
}
