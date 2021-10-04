import 'package:credicxo_task_music_app/controller/music_tracker_controller.dart';
import 'package:credicxo_task_music_app/model/music_model.dart';
import 'package:credicxo_task_music_app/track_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<MusicModel>> fetchTrackList;

  @override
  void initState() {
    super.initState();
    fetchTrackList = MusicTrackerController().fetchTrackingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text('Trending',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ),
      body: Container(
        child: FutureBuilder<List<MusicModel>>(
          future: fetchTrackList,
          builder: (context, snapshot){
            List<MusicModel> model = snapshot.data;
            if(snapshot.hasData){
              //print("HAS DATA : ${snapshot.data.toString()}");
              return ListView.separated(
                itemCount: snapshot.data.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index){
                  MusicModel musicModel = model[index];
                  return musicTrack(musicModel);
                },
              );
            } else if(snapshot.hasError){
              print("Exception : ${snapshot.error.toString()}");
              return Container(child: Center(child: Text("Error"),));
            } else{
              return Container(child: Center(child: CircularProgressIndicator(),),);
            }
          },
        ),
      ),
    );
  }

  Widget musicTrack(MusicModel model){
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: IconButton(
              icon: Icon(Icons.library_music),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => TrackDetails(trackId: model.trackId,)));
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrackDetails(trackId: model.trackId,)));
                    },
                    child: Text("${model.trackName}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        )
                    ),
                  ),
                ),
                Center(
                  child: Text("${model.albumName}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    )
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 4,right: 4),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Text("${model.artistName}"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
