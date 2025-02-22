import 'dart:core';
import 'package:flutter/material.dart';
import 'package:frontend/src/pages/CV/BrowseCvsPage/CvBrowse.dart';
import 'package:frontend/src/pages/CV/CvAddPage/CvAdd.dart';

import 'package:frontend/src/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navigationTapIndex = 0;
  final List<Widget> _children = [
    CvBrowsePage(),
    CvAddPage(),
  ];

  void _onNavigationItemTap(int index) {
    setState(() {
      _navigationTapIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My CVs', style: AppTheme.darkTheme.textTheme.headlineMedium,),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  {print("hello world")} // TODO: search function logic,
              ),
        ],
      ),
      body: _children[_navigationTapIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationTapIndex,
        onTap: _onNavigationItemTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add CV',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_applications_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
