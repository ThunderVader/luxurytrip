import 'package:flutter/material.dart';
import 'package:luharitrip/blocs/travels_bloc.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/resources/luxury_api.dart';
import 'package:luharitrip/ui/favorites_list.dart';
import 'package:luharitrip/ui/filters_container.dart';
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

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    bloc.fetchAllTravels();
    _scrollController = new ScrollController();

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
            Container(height: 36.0,
                child: GestureDetector(child: new Image.asset('assets/logo.png'), onTap: scrollToTop, )
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.airplanemode_active),
        label: Text('Куда?'),
        onPressed: () {
          showModalBottomSheet<Null>(
              builder: (context) {
                return FiltersContainer();
              },
              context: context)
              .then((_) => print(1));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void scrollToTop(){
    _scrollController.animateTo(0, duration: new Duration(seconds: 2), curve: Curves.ease);
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    final travels = snapshot.data.items;
    return ListView.builder(
      controller: _scrollController,
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
