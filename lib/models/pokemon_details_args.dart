import './pokemon_data.dart';

class PokemonDetailsArgs {
  final Pokemon pk;
  final Function selectColor;
  final PokemonData pkData;

  PokemonDetailsArgs({this.pk,this.selectColor,this.pkData});
}