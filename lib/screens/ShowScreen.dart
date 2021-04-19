import 'package:flutter/material.dart';
import '../utils/globals.dart';
import '../utils/ebiAPI.dart';

class ShowScreen extends StatefulWidget {
  @override
  _ShowScreenState createState() => _ShowScreenState();
}

class _ShowScreenState extends State<ShowScreen> {
  Future<List<CurrentLine>> currentTraffic;
  List<CurrentLine> traffic;
  @override
  initState() {
    super.initState();
    // Add listeners to this class
    currentTraffic = EBIapi().fetchTables();
  }

  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<CurrentLine>>(
          future: currentTraffic,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              traffic = snapshot.data;
              print('${traffic[0].name}');
              return Container(width: 0, height: 0);
            } else if (snapshot.hasError) {
              return Text(
                "Invalid",
                key: Key('notification'),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            }

            // By default, show a loading spinner.
            if (snapshot.hasData) {
              return Expanded(child: CircularProgressIndicator());
            } else {
              return Container(width: 0, height: 0);
            }
            //return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
