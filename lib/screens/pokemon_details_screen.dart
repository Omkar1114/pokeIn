import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../widgets/custom_container.dart';
import '../models/pokemon_details_args.dart';

class PokemonDetailsScreen extends StatelessWidget {
  static const routeName = '/pokemon-details';

  Widget buildHeader(
      BuildContext context, PokemonDetailsArgs routeArgs, Color bgColor, MediaQueryData mediaQuery) {
    return Container(
      child: CustomPaint(
        painter: CustomContainer(bgColor),
        child: Container(
          padding: const EdgeInsets.all(25),
          height: mediaQuery.size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    routeArgs.pk.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arvo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '#${routeArgs.pk.num}',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arvo',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildType(MediaQueryData mediaQuery, PokemonDetailsArgs routeArgs) {
    return Positioned(
      top: mediaQuery.size.height * 0.45,
      width: mediaQuery.size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: routeArgs.pk.type
            .map((f) => Container(
                  padding: const EdgeInsets.all(15),
                  width: mediaQuery.size.width * 0.3,
                  decoration: BoxDecoration(
                    color: routeArgs.selectColor(f.toString()),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    f.toString().replaceRange(0, 5, ''),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget buildDetails(
      MediaQueryData mediaQuery, Color bgColor, PokemonDetailsArgs routeArgs) {
    return Positioned(
      top: mediaQuery.size.height * 0.6,
      width: mediaQuery.size.width,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                '${routeArgs.pk.height}',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: bgColor),
              ),
              Text(
                '${routeArgs.pk.weight}',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: bgColor),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Height',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Text(
                'Weight',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWeakness(
      MediaQueryData mediaQuery, PokemonDetailsArgs routeArgs) {
    return Positioned(
      top: mediaQuery.size.height * 0.75,
      width: mediaQuery.size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Weakness',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: routeArgs.pk.weaknesses
                .map(
                  (t) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                        color: routeArgs.selectColor(t.toString()),
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      t.toString().replaceRange(0, 5, ''),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PokemonDetailsArgs routeArgs =
        ModalRoute.of(context).settings.arguments;
    final mediaQuery = MediaQuery.of(context);
    final Color bgColor =
        routeArgs.selectColor(routeArgs.pk.type[0].toString());

    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildHeader(
            context,
            routeArgs,
            bgColor,
            mediaQuery
          ),
          Positioned(
            top: mediaQuery.size.height * 0.4 - 120,
            left: mediaQuery.size.width * 0.5 - 65,
            child: Container(
              height: 150,
              width: 150,
              alignment: Alignment.center,
              child: Hero(
                tag: routeArgs.pk.id,
                child: CachedNetworkImage(
                  imageUrl: routeArgs.pk.img,
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
          ),
          buildType(
            mediaQuery,
            routeArgs,
          ),
          buildDetails(
            mediaQuery,
            bgColor,
            routeArgs,
          ),
          Positioned(
            top: mediaQuery.size.height * 0.6,
            left: mediaQuery.size.width / 2,
            child: Container(
              width: 1,
              height: 70,
              color: bgColor,
            ),
          ),
          buildWeakness(
            mediaQuery,
            routeArgs,
          ),
        ],
      ),
    );
  }
}
