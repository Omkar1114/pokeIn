import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/pokemon_details_args.dart';
import '../screens/pokemon_details_screen.dart';
import '../models/pokemon_data.dart';

class PokemonList extends StatelessWidget {
  final PokemonData pkData;
  final int pkIndex;
  final Function selectColor;

  PokemonList(this.pkData, this.pkIndex, this.selectColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: selectColor(pkData.pokemon[pkIndex].type[0].toString()),
      ),
      child: ListTile(
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
        trailing: Hero(
          tag: pkData.pokemon[pkIndex].id,
          child: CachedNetworkImage(
            imageUrl: pkData.pokemon[pkIndex].img,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          pkData.pokemon[pkIndex].name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pkData.pokemon[pkIndex].type
              .map(
                (f) => Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Text(
                    f.toString().replaceRange(0, 5, ''),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
