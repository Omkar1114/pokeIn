import 'dart:convert';

import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/pokemon_card.dart';
import '../models/pokemon_data.dart';
import '../widgets/pokemon_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokemonData pokemonData;

   Future<void> fetchData() async {
    var res = await get(url);
    var decodedData = jsonDecode(res.body);
    pokemonData = PokemonData.fromJson(decodedData);
    //  print(decodedData);
    setState(() {});
  }


  Color selectColor(String type) {
    switch (type) {
      case 'Type.BUG':
        return Color(0xffA8B820);
        break;
      case 'Type.DARK':
        return Color(0xff705848);
        break;
      case 'Type.DRAGON':
        return Color(0xff7038F8);
        break;
      case 'Type.ELECTRIC':
        return Color(0xffF8D030);
        break;
      case 'Type.FAIRY':
        return Color(0xffEE99AC);
        break;
      case 'Type.FIGHTING':
        return Color(0xffC03028);
        break;
      case 'Type.FIRE':
        return Color(0xffF08030);
        break;
      case 'Type.FLYING':
        return Color(0xffA890F0);
        break;
      case 'Type.GHOST':
        return Color(0xff705898);
        break;
      case 'Type.GRASS':
        return Color(0xff78C850);
        break;
      case 'Type.GROUND':
        return Color(0xffE0C068);
        break;
      case 'Type.ICE':
        return Color(0xff98D8D8);
        break;
      case 'Type.NORMAL':
        return Color(0xffA8A878);
        break;
      case 'Type.POISON':
        return Color(0xffA040A0);
        break;
      case 'Type.PSYCHIC':
        return Color(0xffF85888);
        break;
      case 'Type.ROCK':
        return Color(0xffB8A038);
        break;
      case 'Type.STEEL':
        return Color(0xffB8B8D0);
        break;
      case 'Type.WATER':
        return Color(0xff6890F0);
        break;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: pokemonData == null
          ? Center(
              child: SplashScreen.callback(
                name: 'assets/images/pokeBall_loading.flr',
                until: () => fetchData(),
                startAnimation: 'Pokeball',
                loopAnimation: 'Pokeball',
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 130,
                  backgroundColor: Colors.white,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'PokéIn',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    background: Image.asset(
                      'assets/images/Pokeball.png',
                      alignment: Alignment.topRight,
                      fit: BoxFit.none,
                    ),
                    titlePadding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                  ),
                ),
                isLandscape
                    ? SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int pkindex) {
                          return PokemonCard(
                            pokemonData,
                            pkindex,
                            selectColor,
                          );
                        }, childCount: pokemonData.pokemon.length),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int pkindex) {
                            return PokemonList(
                              pokemonData,
                              pkindex,
                              selectColor,
                            );
                          },
                          childCount: pokemonData.pokemon.length,
                        ),
                      )
              ],
            ),
      backgroundColor: Colors.white,
    );
  }
}
