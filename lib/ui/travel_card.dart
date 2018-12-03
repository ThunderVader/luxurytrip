import 'package:flutter/material.dart';
import 'package:luharitrip/models/item_model.dart';
import 'package:luharitrip/utils/native_utils.dart';
import 'package:meta/meta.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class TravelCard extends StatefulWidget {
  final LinearGradient cardBackgroundGradient;
  final TravelItem travel;
  final VoidCallback onCardClick;
//  final VoidCallback onFavoriteToggle;
  final BuildContext context;
  final Key key;

  TravelCard({@required this.key,
    @required this.cardBackgroundGradient,
    @required this.travel,
    @required this.onCardClick,
//    @required this.onFavoriteToggle,
    @required this.context})
      : assert(travel != null),
        super(key: key);

  @override
  TravelCardState createState() {
    return new TravelCardState();
  }
}

class TravelCardState extends State<TravelCard> {
  bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.travel.isFavorite;
    super.initState();
  }

  final TextStyle titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(
          offset: Offset(1.0, 1.0),
          blurRadius: 3.0,
          color: Color.fromARGB(255, 0, 0, 0),
        )
      ],
      fontFamily: 'GTWalsheimPro');

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = (width * 9 / 16);
    final imgUrl = widget.travel.destination != null
        ?  "https://mphoto.hotellook.com/static/cities/${(width * pixelRatio).round()}x${(height * pixelRatio).round()}/${widget.travel.destination['id']}.jpg"
        : null;

    return Material(
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 0.0),
        child: _background(imgUrl: imgUrl,
          width: width,
          height: height,
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                    color: Colors.black.withOpacity(.4),),
                _cardText(),
                Material(child: Stack(
                  children: <Widget>[InkWell(
                      onTap: widget.onCardClick,
                    ),
              _bookmarkButton(),
              _shareButton()
            ],
          ),),
              ],
            ),),),
      ),
    );
  }

  Widget _cardText(){
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(
              bottom: 6.0, left: 6.0, right: 6.0, top: 25.0),
          child: Text(widget.travel.title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: titleStyle,
            maxLines: 4,
          )
      ),
      Text(
        '${widget.travel.provider} • ${widget.travel.date.hour.toString()
            .padLeft(
            2, '0')}:${widget.travel.date.minute.toString().padLeft(
            2, '0')}',
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }

  Widget _bookmarkButton(){
    return Align(
      alignment: Alignment.bottomLeft,
        child: IconButton(
            icon: isFavorite
                ? Icon(Icons.bookmark)
                : Icon(Icons.bookmark_border),
            color: Colors.white,
            onPressed: (){
              widget.travel.isFavorite = !widget.travel.isFavorite;
              setState(() {
                isFavorite=widget.travel.isFavorite;
              });
            }),
    );
  }

  Widget _shareButton(){
    return Align(
      alignment: Alignment.bottomRight,
        child: IconButton(
            icon: Icon(Icons.share),
            color: Colors.white,
            onPressed: () =>
                showShareDialog(
                    sharingTitle: widget.travel.title,
                    sharingURL: widget.travel.link)),
    );
  }

  Widget _background({child, imgUrl, height, width}){
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Container(
            decoration: BoxDecoration(gradient: widget.cardBackgroundGradient,),
            child: Stack(
              children: [
                  imgUrl != null
                      ? Image.network(
                    imgUrl,
                    height: height,
                    width: width,
                    fit: BoxFit.fill,
                  )
                      : Container(),
                child
              ]
            )
        ),
    );
  }
}
