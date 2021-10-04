import 'package:credicxo_task_music_app/controller/music_lyrics_controller.dart';
import 'package:credicxo_task_music_app/controller/track_details_controller.dart';
import 'package:credicxo_task_music_app/model/music_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackDetails extends StatefulWidget{
  final int trackId;

  const TrackDetails({this.trackId});

  @override
  State<StatefulWidget> createState() {
    return TrackDetailsState();
  }
}

class TrackDetailsState extends State<TrackDetails>{
  Future<MusicModel> fetchTrackDetails;
  Future<MusicModel> fetchLyrics;

  @override
  void initState() {
    super.initState();
    fetchTrackDetails = TrackDetailsController().getTrackDetails(widget.trackId);
    fetchLyrics = MusicLyricsController().getLyrics(widget.trackId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Track Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            FutureBuilder<MusicModel>(
              future: fetchTrackDetails,
              builder: (context, snapshot){
                MusicModel mm = snapshot.data;
                if(snapshot.hasData){
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(mm.trackName,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        children: <Widget>[
                          Text('Artist',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(mm.artistName,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        children: <Widget>[
                          Text('Album Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(mm.albumName,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        children: <Widget>[
                          Text('Explicit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('${mm.explicit}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      Row(
                        children: <Widget>[
                          Text('Rating',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('${mm.trackRating}',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                    ],
                  );
                } else if(snapshot.hasError){
                  return Container(child: Center(child: Text('Error'),),);
                } else{
                  return Container(child: Center(child: CircularProgressIndicator(),),);
                }
              },
            ),

            FutureBuilder<MusicModel>(
              future: fetchLyrics,
              builder: (context, snapshot){
                MusicModel musicModel = snapshot.data;
                if(snapshot.hasData){
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Lyrics',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 330,
                            child: Text("${musicModel.lyricsBody}", maxLines: 100, textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if(snapshot.hasError){
                  print("Exception : ${snapshot.error.toString()}");
                  return Container(child: Center(child: Text('Error'),),);
                } else {
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            ),
          ],
        )
      ),
    );
  }

}