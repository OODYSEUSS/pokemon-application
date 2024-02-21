import 'package:flutter/material.dart';
import 'package:pokemon_application/models/pokemon_list_item_model.dart';
import 'package:pokemon_application/models/pokemon_details_model.dart';
import 'package:pokemon_application/services/api_services.dart';
import 'package:pokemon_application/styles/text_styles.dart';

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
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
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
                Center(
                    child: Image.network(
                  pokemon.frontImageUrl,
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width * 0.6,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pokemon.name,
                      style: textStyleName,
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text(
                          'Type:',
                          style: textStyleAbout,
                        ),
                      ),
                      Container(
                        // width: width * 0.3,
                        child: Text(
                          pokemon.type.join(', '),
                          style: textStyleAboutBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text(
                          'Weight:',
                          style: textStyleAbout,
                        ),
                      ),
                      Container(
                        // width: width * 0.3,
                        child: Text(
                          '${pokemon.weight / 10} kg',
                          style: textStyleAboutBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width * 0.3,
                        child: Text(
                          'Height:',
                          style: textStyleAbout,
                        ),
                      ),
                      Container(
                        // width: width * 0.3,
                        child: Text(
                          '${pokemon.height * 10} cm',
                          style: textStyleAboutBold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
