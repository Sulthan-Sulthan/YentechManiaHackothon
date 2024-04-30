import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:superarui/models/Brain3D.dart';
import 'package:superarui/models/Heart3D.dart';
import 'package:superarui/models/Humanbody3D.dart';
import 'package:superarui/models/Kidney3D.dart';
import 'package:superarui/models/Lungs3D.dart';
import 'package:superarui/models/Pregnantwomen3D.dart';
import 'package:superarui/models/Skeleton3D.dart';

// Enum for image events
enum ImageEvent { toggleSave }

class ImageBloc extends Bloc<ImageEvent, List<Map<String, dynamic>>> {
  ImageBloc() : super([]);

  @override
  Stream<List<Map<String, dynamic>>> mapEventToState(ImageEvent event) async* {
    switch (event) {
      case ImageEvent.toggleSave:
        yield List<Map<String, dynamic>>.from(state.map((item) {
          return item["isSaved"]
              ? {...item, "isSaved": false}
              : {...item, "isSaved": true};
        }));
        break;
    }
  }
}

// UI
class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> _listItem = [
    // {"image": 'assets/images/anatomy/kidney.jpeg', "isSaved": false},
    {"image": 'assets/images/anatomy1/lungs.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/brain.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/heart.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/anatomy.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/kidney.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/pregwomen.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/skelliton.png', "isSaved": false},
    {"image": 'assets/images/anatomy1/humanbody.png', "isSaved": false},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: AssetImage('assets/images/interface.png'),
                          fit: BoxFit.cover)),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.4),
                              Colors.black.withOpacity(.2),
                            ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Augmented Reality",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Center(
                              child: Text(
                            "AI Enabled",
                            style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ImageGrid(images: _listItem),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  final List<Map<String, dynamic>> images;

  ImageGrid({required this.images});

  @override
  Widget build(BuildContext context) {
    final imageBloc = BlocProvider.of<ImageBloc>(context);
    return GridView.count(
      crossAxisCount: 2,
      children: images
          .map((item) => GestureDetector(
                onTap: () {
                  if (item['image'] == 'assets/images/anatomy1/kidney.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KidneyApp(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/lungs.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Lungs(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/brain.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Brain(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/heart.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Heart(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/pregwomen.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pregnantwomen(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/skelliton.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Skeleton(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/humanbody.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Humanbody(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/anatomy.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Humanbody(),
                      ),
                    );
                  } else if (item['image'] ==
                      'assets/images/anatomy1/humanbody.png') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Humanbody(),
                      ),
                    );
                  } else {
                    imageBloc.add(ImageEvent.toggleSave);
                  }
                },
                child: Card(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            item["isSaved"]
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: item["isSaved"]
                                ? Colors.yellow[700]
                                : Colors.white,
                          ),
                          onPressed: () {
                            imageBloc.add(ImageEvent.toggleSave);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('You have navigated to the new page!'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
