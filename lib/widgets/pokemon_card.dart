import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../models/pokemon_details_args.dart';
import '../screens/pokemon_details_screen.dart';
import '../models/pokemon_data.dart';

class PokemonCard extends StatelessWidget {
  final PokemonData pkData;
  final int pkIndex;
  final Function selectColor;

  PokemonCard(this.pkData, this.pkIndex, this.selectColor);

  @override
  Widget build(BuildContext context) {
    final typeLength = pkData.pokemon[pkIndex].type.length;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          PokemonDetailsScreen.routeName,
          arguments: PokemonDetailsArgs(
            pk: pkData.pokemon[pkIndex],
            selectColor: selectColor,
            pkData: pkData,
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      splashColor: Colors.white.withOpacity(0.3),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              selectColor(pkData.pokemon[pkIndex].type[0].toString()),
              typeLength == 2
                  ? selectColor(pkData.pokemon[pkIndex].type[1].toString())
                  : selectColor(pkData.pokemon[pkIndex].type[0].toString())
                      .withOpacity(0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 1],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              pkData.pokemon[pkIndex].name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              width: 80,
              child: Hero(
                tag: pkData.pokemon[pkIndex].id,
                child: CachedNetworkImage(
                  imageUrl: pkData.pokemon[pkIndex].img,
                  placeholder: (context, url) => FlareActor(
                'assets/images/Poke_Spinner.flr',
                alignment: Alignment.center,
                fit: BoxFit.fill,
                animation: 'pokespin',
              ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
