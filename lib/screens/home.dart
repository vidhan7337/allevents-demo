// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'dart:async';
import 'package:demo_app/models/category.dart';
import 'package:demo_app/models/event.dart';
import 'package:demo_app/screens/authentication/login.dart';
import 'package:demo_app/widgets/eventGridView.dart';
import 'package:demo_app/widgets/eventListView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert'; // required to encode/decode json data
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0; 
  bool listView = true; //switching between list and grid view
  Future<List> eventsFuture = getevents(); //eventlist
  Future<List> categoriesFuture = getCategories(); //categorylist

  //display selected category
  Future<String> displayCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('category')!;
  }

  //fetching categories
  static Future<List> getCategories() async {
    var url =
        Uri.parse("https://allevents.s3.amazonaws.com/tests/categories.json");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final body = json.decode(response.body);

    return body.map((e) => Category.fromJson(e)).toList();
  }

  //fetching events
  static Future<List> getevents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var link = prefs.getString('categoryData')!;
    var url = Uri.parse(link);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final body = json.decode(response.body);
    var x = body['item'];
    return x.map((e) => Item.fromJson(e)).toList();
  }

  //botto, sheet for selecting category
  void selectCategory() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                ),
                SizedBox(
                  height: 15,
                ),
                //displaying categories from api
                Expanded(
                  child: FutureBuilder<List>(
                    future: categoriesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                            width: 50,
                            height: 50,
                            child: Center(child: CircularProgressIndicator()));
                      } else if (snapshot.hasData) {
                        final events = snapshot.data!;
                        return buildCategoryGrid(events);
                      } else {
                        return const Text("No data available");
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.9),
      //bottom navigation bar with three buttons
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.09,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue.shade300,
                  ),
                  onPressed: () {},
                ),
                Text(
                  "Explore",
                  style: TextStyle(color: Colors.blue.shade300),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.feed,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  "Feed",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  "Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            // Search bar , back button and logout button
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.blue.shade300,
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  flex: 25,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // Add your search logic here
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    icon: Icon(
                      Icons.logout,
                      color: Colors.blue.shade300,
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              //Category Selection, Date Selection and View Selection
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectCategory();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            color: Colors.blue.shade300,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FutureBuilder(
                            future: displayCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              } else if (snapshot.hasData) {
                                final events = snapshot.data!;
                                return Text(
                                  events.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.blue.shade300),
                                );
                              } else {
                                return Text(
                                  "Category",
                                  style: TextStyle(color: Colors.blue.shade300),
                                );
                                ;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.24,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Date",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (listView == false)
                          listView = true;
                        else
                          listView = false;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        children: [
                          listView ? Icon(Icons.list) : Icon(Icons.grid_view),
                          SizedBox(
                            width: 5,
                          ),
                          listView
                              ? Text(
                                  "List View",
                                  style: TextStyle(color: Colors.black),
                                )
                              : Text(
                                  "Grid View",
                                  style: TextStyle(color: Colors.black),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Event List View
          Expanded(
            child: FutureBuilder<List>(
              future: eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                      width: 50,
                      alignment: Alignment.topCenter,
                      height: 50,
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasData) {
                  final events = snapshot.data!;
                  return listView
                      ? buildEventList(events)
                      : buildEventListGrid(events);
                } else {
                  return const Text("No data available");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

//Category Grid in Bottom Sheet
  buildCategoryGrid(List categories) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('category', categories[index].category);
            prefs.setString('categoryData', categories[index].data);
            setState(() {
              currentIndex = index;
              eventsFuture = getevents();
            });
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: currentIndex == index
                    ? Colors.blue.shade300
                    : Colors.grey.shade100,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(25)),
            child: Center(
                child: Text(
              "${categories[index].category}",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black),
            )),
          ),
        );
      },
    );
  }
}
