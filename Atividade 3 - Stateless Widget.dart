//import para o framework Flutter
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

//
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: PokemonPage());
  }
}
// estabeleci essa sequencia e organização dentro do Dartpad

//IA Prompt: De exemplos de classes de pokemons para serem StatelessWidget
class PokemonPage extends StatelessWidget {
  // StatelessWidget é imutavel
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //esqueleto
      appBar: AppBar(
        //
        title: Text("Pokédex Pokémon Card "),
        backgroundColor: Colors.deepOrange, //
      ),
      // Cores de fundo definidas pelos objetos Colors com
      backgroundColor: Colors.orange.shade100,
      body: Column(
        children: [
          PokemonCard(
            name: "Charizard",
            type: "Fogo / Voador",
            imageUrl:
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png",
          ),

          // StatBar = um StatelessWidget personalizado que mostra uma barra proporcional
          StatBar(
            label: "HP",
            value: 80,
            maxValue: 100,
            color: Colors.red,
          ),

          StatBar(
            label: "XP",
            value: 45,
            maxValue: 100,
            color: Colors.green,
          ),

          // elemento para list de ataques do pokemon
          Expanded(
            child: MoveList(
              moves: [
                "Lança-chamas",
                "Voar",
                "Corte",
                "Giro de Fogo",
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// CARD DO POKEMON

class PokemonCard extends StatelessWidget {
  final String name;
  final String type;
  final String imageUrl;

  const PokemonCard({
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  @override // sobrescreve metodo
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.catching_pokemon,
                    size: 60,
                    color: Colors.red,
                  ),
                  Image.network(imageUrl, width: 60),
                ],
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(type),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// STAT BAR

class StatBar extends StatelessWidget {
  final String label;
  final double value;
  final double maxValue;
  final Color color;

  const StatBar({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // efeito de progressão da barra usando value dividido pelo máximo(maxValue)
    double percent = value / maxValue;

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: ${value.toInt()} / ${maxValue.toInt()}"),

          SizedBox(height: 5), //conteudo dentro da caixa

          // contrutor do layout
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                height: 20,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),

                // filho herdado para fazer a Stack
                child: Stack(
                  children: [
                    Container(
                      width: constraints.maxWidth * percent,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// LISTA DE GOLPES
// classe para lista de movimentos com customização dentro do código
class MoveList extends StatelessWidget {
  final List<String> moves;

  const MoveList({required this.moves});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: moves.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(
            Icons.flash_on,
            color: Colors.orange,
          ),
          title: Text(moves[index]),
        );
      },
    );
  }
}