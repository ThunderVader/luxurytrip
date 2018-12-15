import 'package:flutter/material.dart';
import 'package:luharitrip/blocs/travels_bloc.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/resources/luxury_api.dart';
import 'package:luharitrip/ui/favorites_list.dart';
import 'package:luharitrip/ui/travel_card.dart';
import 'package:luharitrip/utils/gradients.dart';
import 'package:luharitrip/utils/native_utils.dart';

class TravelList extends StatefulWidget {
  final LuxuryApi api;

  TravelList({Key key, LuxuryApi api})
      : this.api = api ?? LuxuryApi(),
        super(key: key);

  TravelListState createState() {
    return TravelListState();
  }
}

class TravelListState extends State<TravelList> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllTravels();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black45,
            ),
            onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => FavoritesList())),
            ),
        title:
            Container(height: 36.0, child: new Image.asset('assets/logo.png')),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: bloc.allTravels,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              backgroundColor: Colors.white,
              child: buildList(snapshot),
              onRefresh: () => bloc.fetchAllTravels(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
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
}
