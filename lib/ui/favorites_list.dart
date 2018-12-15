import 'package:flutter/material.dart';
import 'package:luharitrip/blocs/favorite_block.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/ui/travel_card.dart';
import 'package:luharitrip/utils/gradients.dart';
import 'package:luharitrip/utils/native_utils.dart';


class FavoritesList extends StatefulWidget {
  @override
  FavoritesListState createState() {
    return new FavoritesListState();
  }
}

class FavoritesListState extends State<FavoritesList>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.black45,
              ),
              onPressed: () => Navigator.pop(context)),
          centerTitle: true,
          title: Text(
            'Избранное',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder(
          stream: favoriteBloc.allTravels,
          builder: (context, AsyncSnapshot<ItemModelDB> snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                backgroundColor: Colors.white,
                child: buildList(snapshot),
                onRefresh: () => favoriteBloc.fetchAllTravels(),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        backgroundColor: Colors.white,
      ); //);
  }

  Widget buildList(AsyncSnapshot<ItemModelDB> snapshot) {
    final travels = snapshot.data.items;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final travel = travels[index];
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  bottom: index == travels.length - 1 ? 8.0 : 0.0),
              child: TravelCard(
                travel,
                key: new Key(travel.id.toString()),
                cardBackgroundGradient:
                gradientList[index % gradientList.length],
                context: context,
                onCardClick: () => openWebView(travel.link),
              ),
            ),
          ],
        );
      },
      itemCount: travels.length,
    );
  }

  @override
  void initState() {
    favoriteBloc.fetchAllTravels();
    super.initState();
  }
}
