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

  void _onItemTapped(int index) {
    setState(() {});
  }

  Widget bottomMenu(BuildContext context) {
    return new BottomNavigationBar(
      key: Key('bottom-bar'),
      backgroundColor: Color(0xFFE5251E),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: (Icon(Icons.refresh_sharp)),
          label: 'Refresh',
        ),
      ],
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent[200],
        title: Text(
          "EBI Operators",
          key: Key('welcome'),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<List<CurrentLine>>(
              future: currentTraffic,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  traffic = snapshot.data;
                  return Container(
                      child: Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(1),
                      itemCount: traffic.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: Colors.grey[300],
                            child: ExpansionTile(
                              key: Key('MainTile'),
                              title: Text(
                                '${traffic[index].tag}',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    'Company: ${traffic[index].name}',
                                  ),
                                ),
                                ListTile(
                                  title: Text('Hour: ${traffic[index].hour}'),
                                ),
                                ListTile(
                                  title: Text('PO: ${traffic[index].order}'),
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(thickness: 0),
                    ),
                  ));
                } else if (snapshot.hasError) {
                  return Text(
                    "Request Error",
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(child: CircularProgressIndicator());
                } else {
                  return Text("No pending trucks.");
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomMenu(context),
    );
  }
}
