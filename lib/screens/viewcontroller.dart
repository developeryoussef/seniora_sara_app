// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, avoid_unnecessary_containers, library_private_types_in_public_api, unused_field, use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';


class ViewController extends StatefulWidget {
  @override
  _ViewControllerState createState() => _ViewControllerState();
}

class _ViewControllerState extends State<ViewController> {
  @override
  void initState() {
    sharedPreferences!.getString('term') != 'firsterm' ||
            sharedPreferences!.getString('term') != 'secondterm'
        ? sharedPreferences!.setString('term', 'firsterm')
        : null;

    super.initState();
  }

  int currentindex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AddQuizPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentindex != 2
          ? AppBar(
              iconTheme: currentindex == 2 ? null : IconThemeData.fallback(),
              actions: currentindex != 2
                  ? null
                  : [
                      IconButton(onPressed: () {}, icon: Icon(LineIcons.search))
                    ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                'Signora Sara Quizes',
                style: TextStyle(color: Colors.black),
              ),
            )
          : null,
      backgroundColor: itGrey,
      body: _widgetOptions[currentindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: itGrey,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey.shade300,
              hoverColor: Colors.grey[300]!,
              gap: 13,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 600),
              tabBackgroundColor: itGreen,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.ad,
                  text: 'Add Quiz',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
              ],
              selectedIndex: currentindex,
              onTabChange: (index) {
                setState(() {
                  currentindex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
