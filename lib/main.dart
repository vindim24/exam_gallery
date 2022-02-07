import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test/pages/full_photo_page.dart';

void main() {
  runApp(const ExamGallery());
}

class ExamGallery extends StatefulWidget {
  const ExamGallery({Key? key}) : super(key: key);

  @override
  _ExamGalleryState createState() => _ExamGalleryState();
}

class _ExamGalleryState extends State<ExamGallery> {
  List<Widget> events = <Widget>[];

  bool isLoaded = false;

  @override
  void initState() {
    loadKagune();
    super.initState();
  }

  void loadKagune() async {
    var response = await Dio().get(
        "https://api.unsplash.com/photos/?client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043");

    setState(() {
      events = (response.data as List<dynamic>).map((e) {
        var image = e['urls']['thumb'];
        var fullImage = e["urls"]["regular"];
        var name = e['user']['name'];

        //double width = MediaQuery.of(context).size.width;

        return Column(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Builder(builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        Route route = MaterialPageRoute(
                            builder: (context) =>
                                FullPhotoPage(fullImage: fullImage));
                        Navigator.push(context, route);
                      },
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage('$image'),
                                          fit: BoxFit.cover),
                                    ),
                                    height: 100,
                                    width: 140,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        );
      }).toList();
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          centerTitle: true,
          title: const Text(
            "Exam Gallery",
            style: TextStyle(
              fontSize: 26,
              color: Colors.grey,
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFAF9FE),
          ),
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (isLoaded) {
                return EventsList(events: events);
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class EventsList extends StatelessWidget {
  final List<Widget> events;

  const EventsList({Key? key, required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: events,
    );
  }
}
