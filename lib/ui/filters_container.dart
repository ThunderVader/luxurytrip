import 'package:flutter/material.dart';
import 'package:luharitrip/models/location_model.dart';
import 'package:luharitrip/resources/repository.dart';
import 'package:luharitrip/ui/direction_chips.dart';

class FiltersContainer extends StatefulWidget {

  @override
  FiltersContainerState createState() {
    return new FiltersContainerState();
  }
}

class FiltersContainerState extends State<FiltersContainer> {

  LocationModel locations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
        ),
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Куда',
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    )),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Material(
                    type: MaterialType.transparency,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ),
            ]),
            FutureBuilder(
              future: repository.fetchDirections(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? _directionsChips(snapshot.data, context) // return the ListView widget
                    : Center(child: CircularProgressIndicator());
              }),
          ],
        ));
  }

  Widget _directionsChips(data, context){
    return SingleChildScrollView(
        child: Wrap(
            children: data.items
                .map<Widget>((Location direction) {
              return DirectionChip(
                direction: direction,
                primeColor: Theme.of(context).accentColor,
                isSelected: direction.isSelected,
                toggleSelection: (_){
                  direction.isSelected=!direction.isSelected;
                },
              );
            }).toList()));
  }
}
