import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckInternet{
  void _showDialog(BuildContext context, VoidCallback callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text("No Internet"),
              content: new Text("Please Check your Network Connection"),
              actions: <Widget>[
                new TextButton(
                    onPressed: () async{
                      callback();
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromRGBO(71, 171, 67, 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )
                    ),
                    child: new Text("Retry"))
              ]
          );
        }
    );
  }

  Future<bool> isInternet(BuildContext context, VoidCallback cb) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print("Connected with mobile data");
        return true;
      } else {
        _showDialog(context, cb);
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print("Connected with wifi");
        return true;
      } else {
        _showDialog(context,cb);
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      _showDialog(context, cb);
      return false;
    }
  }
}