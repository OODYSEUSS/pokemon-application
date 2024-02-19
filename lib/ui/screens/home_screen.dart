import 'dart:convert' show jsonDecode;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokemonApi = "https://pokeapi.co/api/v2/pokemon";
  late List pokemon = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(52, 102, 175, 1),
        title: const Text(
          'Pokemon',
          style: TextStyle(color: Color.fromRGBO(255, 203, 5, 1), fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pokemon.length,
              itemBuilder: (context, index) {
                if (pokemon.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pokemon[index]["name"],
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void fetchPokemonData() {
    var url = Uri.https("pokeapi.co", "/api/v2/pokemon");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(value.body);
        List<dynamic> results = data['results'];
        setState(() {
          pokemon = results;
        });
      }
    });
  }
}
