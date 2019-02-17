import 'package:flutter/material.dart';
import 'package:luharitrip/models/location_model.dart';

class DirectionChip extends StatelessWidget {
  final Location direction;
  final Color primeColor;
  final bool isSelected;
  final Function(Location) toggleSelection;

  const DirectionChip(
      {Key key,
        this.direction,
        this.primeColor,
        this.isSelected,
        this.toggleSelection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {toggleSelection(direction);},
        child: Container(
          padding: const EdgeInsets.only(
              top: 6.0, bottom: 6.0, left: 8.0, right: 8.0),
          decoration: BoxDecoration(
              color: isSelected ? primeColor : Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              border: Border.all(color: primeColor)),
          child: Text(
            direction.name,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
          key: ValueKey<String>(direction.code),
        ),
      ),
    );
  }
}