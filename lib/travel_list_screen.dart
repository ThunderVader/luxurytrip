import 'package:flutter/material.dart';
import 'package:luharitrip/filter_bloc.dart';
import 'package:luharitrip/luxury_api.dart';
import 'package:luharitrip/search_loading_widget.dart';
import 'package:luharitrip/travels_list_state.dart';

class TravelListScreen extends StatefulWidget{
  final LuxuryApi api;

  TravelListScreen({Key key, LuxuryApi api})
      : this.api = api ?? LuxuryApi(),
        super(key: key);

  TravelListScreenState createState(){
    return TravelListScreenState();
  }
}

class TravelListScreenState extends State<TravelListScreen>{
  FilterBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = FilterBloc(widget.api);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TravelsLoadingState>(
      stream: bloc.state,
      initialData: TravelsLoading(),
      builder: (BuildContext context, AsyncSnapshot<TravelsLoadingState> snapshot) {
        final state = snapshot.data;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Fade in an intro screen if no term has been entered
//                      SearchIntro(visible: state is SearchNoTerm),
//
//                      // Fade in an Empty Result screen if the search contained
//                      // no items
//                      EmptyWidget(visible: state is SearchEmpty),

                      // Fade in a loading screen when results are being fetched
                      // from Github
                      LoadingWidget(visible: state is TravelsLoading),

                      // Fade in an error if something went wrong when fetching
                      // the results
//                      SearchErrorWidget(visible: state is SearchError),
//
//                      // Fade in the Result if available
//                      SearchResultWidget(
//                        items:
//                        state is SearchPopulated ? state.result.items : [],
//                      ),
                    ],
                  ),
                )
              ])
            ],
          ),
        );
      },
    );
  }

}