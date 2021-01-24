import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';


void main() => runApp(MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Starhacks 2021';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> with TickerProviderStateMixin{
  int currentIndex;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  bool success = false;

  //variable for current dat and time used in the pathway page
  DateTime now = new DateTime.now();

  //variables for pathway form
  double q1 = 0;
  double q2 = 0;
  double q3 = 0;
  double q4 = 0;
  double q5 = 0;
  double q6 = 0;
  double q7 = 0;
  double q8 = 0;
  double q9 = 0;
  double q10 = 0;
  double q11 = 0;
  double q12 = 0;
  double q13 = 0;
  double q14 = 0;

  double dailyQ = 0;

  double dailySleep = 5;

  //list for storing wellness-check data
  static List<String> data = [];
  static List<String> dailyData = [];
  static List<String> dailySleepData = [];


  //motivational quote
  String mq;

  //breathe animation vars
  AnimationController _breathingController;
  var _breathe = 0.0;

  //list of motivational quotes
  List<String> motivational = ["“All our dreams can come true, if we have the courage to pursue them.” – Walt Disney",
    "“The secret of getting ahead is getting started.” – Mark Twain",
    "“I’ve missed more than 9,000 shots in my career. I’ve lost almost 300 games. 26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life and that is why I succeed.” – Michael Jordan",
    "“Don’t limit yourself. Many people limit themselves to what they think they can do. You can go as far as your mind lets you. What you believe, remember, you can achieve.” – Mary Kay Ash",
    "“The best time to plant a tree was 20 years ago. The second best time is now.” – Chinese Proverb",
    "“It’s hard to beat a person who never gives up.” – Babe Ruth",
    "“If people are doubting how far you can go, go so far that you can’t hear them anymore.” – Michele Ruiz",
    "“You’ve gotta dance like there’s nobody watching, love like you’ll never be hurt, sing like there’s nobody listening, and live like it’s heaven on earth.” ― William W. Purkey"
  ];

  //random variable
  var rng = new Random();


  @override
  void initState() {
    super.initState();

      _breathingController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
      _breathingController.addStatusListener((status) async{
        if(status == AnimationStatus.completed){
          await Future.delayed(Duration(seconds: 1));
          _breathingController.reverse();
        }else if(status == AnimationStatus.dismissed){
          await Future.delayed(Duration(seconds: 1));
          _breathingController.forward();
        }
      });
      
      _breathingController.addListener(() {
        setState(() {
          _breathe = _breathingController.value;
        });
      });
      _breathingController.forward();

    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
    //quote for insights page
    mq = motivational[(rng.nextInt(motivational.length))];
  }

  @override
  Widget build(BuildContext context) {
    //breathing animation var
    final size = 400.0-200.0*_breathe;
    return Scaffold(
        key: _scaffoldKey,
        appBar: (currentIndex == 0)
        ? AppBar(
      title: Center(child: Text('Pathway',
        style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),),
      backgroundColor: Colors.lightBlue[100],
    )
        : (currentIndex == 1)
        ? AppBar(
      title: Center(child: Text('Breathe',
          style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),),
      backgroundColor: Colors.lightBlue[100],
    )
        : (currentIndex == 2)
        ? AppBar(
      title: Center(child: Text('Insights',
          style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),),
      backgroundColor: Colors.lightBlue[100],
    )
        : (currentIndex == 3)
        ? AppBar(
      title: Center(child: Text('Get Help',
          style: TextStyle(color: Colors.black.withOpacity(0.8)),
      ),),
      backgroundColor: Colors.lightBlue[100],
    ): Container,
    bottomNavigationBar: BubbleBottomBar(
      opacity: 0.2,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      currentIndex: currentIndex,
      hasInk: true,
      inkColor: Colors.black12,
      hasNotch: true,
      onTap: changePage,
      items: <BubbleBottomBarItem>[
        BubbleBottomBarItem(
          backgroundColor: Colors.lightBlue[100],
          icon: Icon(Icons.directions_walk_rounded, color: Colors.black),
          activeIcon: Icon(Icons.directions_walk_rounded, color: Colors.lightBlue[100]),
          title: Text('Pathway'),
        ),

        BubbleBottomBarItem(
          backgroundColor: Colors.lightBlue[100],
          icon: Icon(Icons.cloud_outlined, color: Colors.black),
          activeIcon: Icon(Icons.cloud_outlined, color: Colors.lightBlue[100]),
          title: Text('Breathe'),
        ),

        BubbleBottomBarItem(
          backgroundColor: Colors.lightBlue[100],
          icon: Icon(Icons.insert_chart_rounded, color: Colors.black),
          activeIcon: Icon(Icons.insert_chart_rounded, color: Colors.lightBlue[100]),
          title: Text('Insights'),
        ),

        BubbleBottomBarItem(
          backgroundColor: Colors.lightBlue[100],
          icon: Icon(Icons.help_center_rounded, color: Colors.black),
          activeIcon: Icon(Icons.help_center_rounded, color: Colors.lightBlue[100]),
          title: Text('Help'),
        ),
      ],
    ),
      body: (currentIndex == 0)
            //center line on page
          ? Stack(children: <Widget>[Center(child: VerticalDivider(color: Colors.black26, thickness: 3,),),
              //Buttons for the pathway
              Center(child: Align(alignment: Alignment(0, 0.7),
              child: FloatingActionButton.extended(
                onPressed: () {
                  if(DateFormat('EEEE').format(now) == "Sunday"){
                    _scaffoldKey.currentState.showBottomSheet(
                          (context) => ListView(children: <Widget>[
                            Container(alignment: Alignment.center, child: Text("Wellness Check-In", style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),),),
                            Row(children: <Widget>[
                              //Question 1
                              Expanded(child: Text("I've been feeling optimistic about the future.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q1,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      //q1 = 4;
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q1 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 2
                              Expanded(child: Text("I’ve been feeling useful.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q2,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q2 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 3
                              Expanded(child: Text("I’ve been feeling relaxed.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q3,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q3 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 4
                              Expanded(child: Text("I’ve been feeling interested in other people.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q4,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q4 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 5
                              Expanded(child: Text("I’ve had energy to spare.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q5,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q5 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 6
                              Expanded(child: Text("I’ve been dealing with problems well.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q6,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q6 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 7
                              Expanded(child: Text("I’ve been thinking clearly.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q7,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q7 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 8
                              Expanded(child: Text("I’ve been feeling good about myself.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q8,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q8 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 9
                              Expanded(child: Text("I’ve been feeling close to other people.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q9,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q9 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 10
                              Expanded(child: Text("I’ve been feeling confident.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q10,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q10 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 11
                              Expanded(child: Text("I’ve been able to make up my own mind about things.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q11,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q11 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 12
                              Expanded(child: Text("I’ve been feeling loved.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q12,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q12 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 13
                              Expanded(child: Text("I’ve been interested in new things.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q13,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q13 = rating;
                                },
                              ),),
                            ],),Row(children: <Widget>[
                              //Question 14
                              Expanded(child: Text("I’ve been feeling cheerful.", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: q14,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return Icon(
                                        Icons.sentiment_very_dissatisfied,
                                        color: Colors.red,
                                      );
                                    case 1:
                                      return Icon(
                                        Icons.sentiment_dissatisfied,
                                        color: Colors.redAccent,
                                      );
                                    case 2:
                                      return Icon(
                                        Icons.sentiment_neutral,
                                        color: Colors.amber,
                                      );
                                    case 3:
                                      return Icon(
                                        Icons.sentiment_satisfied,
                                        color: Colors.lightGreen,
                                      );
                                    case 4:
                                      return Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Colors.green,
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  print(rating);
                                  q14 = rating;
                                },
                              ),),
                            ],),
                            RawMaterialButton(onPressed: () async{
                              double sum = q1 + q2 + q3 + q4 + q5 + q6 + q7 + q8 + q9 + q10 + q11 + q12 + q13 + q14;
                              if(!data.contains(DateTime.now().toString().substring(0, 10) + " " + sum.toString())) {
                                data.add(DateTime.now().toString().substring(0, 10) + " " + sum.toString());
                              }
                              q1 = 0;
                              q2 = 0;
                              q3 = 0;
                              q4 = 0;
                              q5 = 0;
                              q6 = 0;
                              q7 = 0;
                              q8 = 0;
                              q9 = 0;
                              q10 = 0;
                              q11 = 0;
                              q12 = 0;
                              q13 = 0;
                              q14 = 0;

                              await Future.delayed(Duration(seconds: 1));

                              Navigator.pop(context);
                            },
                              fillColor: Colors.lightBlue[100],
                              child: Text("Save"),
                            )
                        ],
                      ),
                    );}else{
                      _scaffoldKey.currentState.showBottomSheet(
                          (context) => ListView(children: <Widget>[
                          Row(children: <Widget>[
                            //Question 1
                            Expanded(child: Text("How are you today?", textAlign: TextAlign.center,),),
                            Expanded(child: RatingBar.builder(
                              initialRating: dailyQ,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Icon(
                                      Icons.sentiment_very_dissatisfied,
                                      color: Colors.red,
                                    );
                                  case 1:
                                    return Icon(
                                      Icons.sentiment_dissatisfied,
                                      color: Colors.redAccent,
                                    );
                                  case 2:
                                    return Icon(
                                      Icons.sentiment_neutral,
                                      color: Colors.amber,
                                    );
                                  case 3:
                                  //q1 = 4;
                                    return Icon(
                                      Icons.sentiment_satisfied,
                                      color: Colors.lightGreen,
                                    );
                                  case 4:
                                    return Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Colors.green,
                                    );
                                }
                              },
                              onRatingUpdate: (rating) {
                                dailyQ = rating;
                              },
                            ),),
                          ],),Row(children: <Widget>[
                              //Question 1
                              Expanded(child: Text("How many hours of sleep did you get?", textAlign: TextAlign.center,),),
                              Expanded(child: RatingBar.builder(
                                initialRating: dailySleep,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  switch (index) {
                                    case 0:
                                      return FloatingActionButton.extended(
                                        onPressed: (){},
                                        label: Text("<5"),
                                      );
                                    case 1:
                                      return FloatingActionButton.extended(
                                        onPressed: (){},
                                        label: Text("6"),
                                      );
                                    case 2:
                                      return FloatingActionButton.extended(
                                        onPressed: (){},
                                        label: Text("7"),
                                      );
                                    case 3:
                                    //q1 = 4;
                                      return FloatingActionButton.extended(
                                        onPressed: (){},
                                        label: Text("8"),
                                      );
                                    case 4:
                                      return FloatingActionButton.extended(
                                        onPressed: (){},
                                        label: Text(">9"),
                                      );
                                  }
                                },
                                onRatingUpdate: (rating) {
                                  dailySleep = rating;
                                },
                              ),),
                            ],),
                            RawMaterialButton(onPressed: () async{
                              if(!dailyData.contains(DateTime.now().toString().substring(0, 10) + " " + dailyQ.toString())) {
                                dailyData.add(DateTime.now().toString().substring(0, 10) + " " + dailyQ.toString());
                              }
                              if(!dailySleepData.contains(DateTime.now().toString().substring(0, 10) + " " + dailySleep.toString())) {
                                dailySleepData.add(DateTime.now().toString().substring(0, 10) + " " + dailySleep.toString());
                              }
                              dailyQ = 0;
                              dailySleep = 5;

                              await Future.delayed(Duration(seconds: 1));

                              Navigator.pop(context);
                            },
                              fillColor: Colors.lightBlue[100],
                              child: Text("Save"),
                            )
                        ],),);
                    };
                  },
                label: Text(now.toString().substring(8,10)),
                backgroundColor: Colors.blueAccent[100],
              ),
          ),), Center(child: Align(alignment: Alignment(0, 0.3),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text((now.add(Duration(days: 1))).toString().substring(8,10)),
                backgroundColor: Colors.grey,
              ),
            ),), Center(child: Align(alignment: Alignment(0, -0.1),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text((now.add(Duration(days: 2))).toString().substring(8,10)),
                backgroundColor: Colors.grey,
              ),
            ),), Center(child: Align(alignment: Alignment(0, -0.5),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text((now.add(Duration(days: 3))).toString().substring(8,10)),
                backgroundColor: Colors.grey,
              ),
            ),), Center(child: Align(alignment: Alignment(0, -0.9),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text((now.add(Duration(days: 4))).toString().substring(8,10)),
                backgroundColor: Colors.grey,
              ),
            ),), Center(child: Align(alignment: Alignment(0, 1.1),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text((now.add(Duration(days: -1))).toString().substring(8,10)),
                backgroundColor: Colors.grey,
              ),
            ),),]
          )
          :(currentIndex == 1)
          ? Stack(children: [
            Align(alignment: Alignment(0, -0.8), child: Text("Take 3 deep breaths with the animation, You got this!", style: TextStyle(fontSize: 20),),),
              Align(alignment: Alignment.center, child:  Container(
                height: size,
                width: size,
                child: Material(
                  borderRadius: BorderRadius.circular(size/3),
                  color: Colors.lightBlue[100],
                ),
              )),
          ])
          //:(currentIndex == 2 && data.length >= 5)
          :(currentIndex == 2)
          ? SingleChildScrollView(child: Column(children: <Widget>[Container(alignment: Alignment.center, margin: const EdgeInsets.all(10.0),
              child: LineGraph(
                      features: [
                        Feature(
                          title: "Wellness Stats",
                          color: Colors.lightBlue[100],
                          data: [2/7, 3/7, 1/7, 7/7, 6/7],
                          //data: [double.parse(data[data.length - 5].substring(12))/70, double.parse(data[data.length - 4].substring(12))/70, double.parse(data[data.length - 3].substring(12))/70, double.parse(data[data.length - 2].substring(12))/70, double.parse(data[data.length - 1].substring(12))/70],
                        ),
                      ],
                      size: Size(400, 480),
                      labelX: ['Day ' + (data.length - 4).toString(), 'Day ' + (data.length - 3).toString(), 'Day ' + (data.length - 2).toString(), 'Day ' + (data.length - 1).toString(), 'Day ' + (data.length - 0).toString()],
                      labelY: ['10', '20', '30', '40', '50', '60', '70'],
                      showDescription: true,
                      graphColor: Colors.black45,)
              ),
                Container(alignment: Alignment.center, margin: const EdgeInsets.all(10.0),
                    child: LineGraph(
                      features: [
                        Feature(
                          title: "Sleep Stats",
                          color: Colors.lightBlue[100],
                          data: [2/7, 3/7, 1/7, 7/7, 6/7],
                          //data: [double.parse(dailySleepData[dailySleepData.length - 5].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 4].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 3].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 2].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 1].substring(12))/5],
                        ),
                        Feature(
                          title: "Mood Stats",
                          color: Colors.greenAccent,
                          data: [2/7, 3/7, 1/7, 7/7, 6/7],
                          //data: [double.parse(dailyData[dailyData.length - 5].substring(12))/5, double.parse(dailyData[dailyData.length - 4].substring(12))/5, double.parse(dailyData[dailyData.length - 3].substring(12))/5, double.parse(dailyData[dailyData.length - 2].substring(12))/5, double.parse(dailyData[dailyData.length - 1].substring(12))/5],
                        ),
                      ],
                      size: Size(400, 480),
                      labelX: ['Day ' + (dailyData.length - 4).toString(), 'Day ' + (dailyData.length - 3).toString(), 'Day ' + (dailyData.length - 2).toString(), 'Day ' + (dailyData.length - 1).toString(), 'Day ' + (dailyData.length - 0).toString()],
                      labelY: ['Bad - <5', 'Poor - 6', 'OK - 7', 'Good - 8', 'Great - 9'],
                      showDescription: true,
                      graphColor: Colors.black45,)
                ),
              Container(alignment: Alignment.center, margin: const EdgeInsets.all(10.0), child: Text(mq),)
            ]
          ))
          /*:(currentIndex == 2 && dailyData.length >= 5)
          ? Column(children: <Widget>[Container(alignment: Alignment.center, margin: const EdgeInsets.all(10.0),
          child: LineGraph(
            features: [
              Feature(
                title: "Sleep Stats",
                color: Colors.lightBlue[100],
                data: [2/7, 3/7, 1/7, 7/7, 6/7],
                //data: [double.parse(dailySleepData[dailySleepData.length - 5].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 4].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 3].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 2].substring(12))/5, double.parse(dailySleepData[dailySleepData.length - 1].substring(12))/5],
              ),
              Feature(
                title: "Mood Stats",
                color: Colors.greenAccent,
                data: [2/7, 3/7, 1/7, 7/7, 6/7],
                //data: [double.parse(dailyData[dailyData.length - 5].substring(12))/5, double.parse(dailyData[dailyData.length - 4].substring(12))/5, double.parse(dailyData[dailyData.length - 3].substring(12))/5, double.parse(dailyData[dailyData.length - 2].substring(12))/5, double.parse(dailyData[dailyData.length - 1].substring(12))/5],
              ),
            ],
            size: Size(400, 480),
            labelX: ['Day ' + (dailyData.length - 4).toString(), 'Day ' + (dailyData.length - 3).toString(), 'Day ' + (dailyData.length - 2).toString(), 'Day ' + (dailyData.length - 1).toString(), 'Day ' + (dailyData.length - 0).toString()],
            labelY: ['Bad - <5', 'Poor - 6', 'OK - 7', 'Good - 8', 'Great - 9'],
            showDescription: true,
            graphColor: Colors.black45,)
      ),Container(alignment: Alignment.center, margin: const EdgeInsets.all(10.0), child: Text(mq),)
      ],)
          :(currentIndex == 2 && dailyData.length <= 5)
          ? Center(child: Text("Come back in a few days to get more information!"))*/
          :(currentIndex == 3)
          ? SingleChildScrollView(child: Column(children: [Container(alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: new FloatingActionButton.extended(
                  onPressed: () {
                    launch("https://suicidepreventionlifeline.org/chat/");
                  },
                  label: Text("Chat with Lifeline", style: TextStyle(fontSize: 20),),
                backgroundColor: Colors.black12,
              ),
          ),
          Container(alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: new FloatingActionButton.extended(
              onPressed: () {
                launch("https://suicidepreventionlifeline.org/talk-to-someone-now/");
              },
              label: Text("Call Someone: 1(800)-273-8255", style: TextStyle(fontSize: 20),),
              backgroundColor: Colors.black12,
            ),
          ),
          Container(alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: new FloatingActionButton.extended(
              onPressed: () {
                launch("https://www.crisistextline.org/help-for-depression/?gclid=CjwKCAiAr6-ABhAfEiwADO4sfQ6Klwpz3bAv1Oq8EN03xGmaP9kmqQsp7tJdcL698Na6PZRHAc0xUBoCBoAQAvD_BwE");
              },
              label: Text("Crisis Text Line", style: TextStyle(fontSize: 20),),
              backgroundColor: Colors.black12,
            ),
          ),
          Container(alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            child: new FloatingActionButton.extended(
              onPressed: () {
                launch("https://www.betterhelp.com/?utm_source=AdWords&utm_medium=Search_PPC_c&utm_term=mental%20health%20counseling%20near%20me_e&utm_content=54434338959&network=g&placement=&target=&matchtype=e&utm_campaign=384672130&ad_type=text&adposition=&gclid=CjwKCAiAr6-ABhAfEiwADO4sfXvP8Zp8yXPMEff4e9U8C8vfmVoI9S5zrjf0QrG69ThySaAVzpBCVRoC-x8QAvD_BwE");
              },
              label: Text("Find a Counselor", style: TextStyle(fontSize: 20),),
              backgroundColor: Colors.black12,
            ),
          ),
      ],),): Container ,
    );
  }
}