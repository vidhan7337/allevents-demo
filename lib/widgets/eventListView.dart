// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:demo_app/screens/webView.dart';
import 'package:flutter/material.dart';

Widget buildEventList(List events) {
  return ListView.builder(
    itemCount: events.length,
    itemBuilder: (context, index) {
      final event = events[index];
      return GestureDetector(
        //navigate to webview
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => YourWebView(event.eventUrl!)));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
          height: 160,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(event.thumbUrl!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.eventname!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              event.label!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500),
                            ),
                            Text(
                              event.location!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .rectangle, // BoxShape.circle or BoxShape.retangle

                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      blurStyle: BlurStyle.outer),
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                    child: Icon(
                                  Icons.ios_share,
                                  color: Colors.grey,
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .rectangle, // BoxShape.circle or BoxShape.retangle

                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      blurStyle: BlurStyle.outer),
                                ],
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                    child: Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    },
  );
}

