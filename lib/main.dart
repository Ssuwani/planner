import 'package:flutter/material.dart';

import 'event_page.dart';
import 'task_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // 정적위젯
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //동적위젯(상태변화)
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isTask = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 45.0,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
            // Stack 위젯은 Position을 이용해서 배치해준다.
            right: 0,
            child: Text(
              '6',
              style: TextStyle(fontSize: 200.0, color: Color(0x10000000)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60.0),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Monday',
                  style: TextStyle(
                    fontSize: 50.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Anton',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isTask = true;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text('Task'),
                        textColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        padding: EdgeInsets.all(14.0),
                      ),
                    ),
                    SizedBox(width: 32.0),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            isTask = false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text('Event'),
                        textColor: Theme.of(context).accentColor,
                        color: Colors.white,
                        padding: EdgeInsets.all(14.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: isTask ? TaskPage() : EventPage(),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
