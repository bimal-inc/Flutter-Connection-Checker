// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_connection/bloc/internetbloc/internet_bloc.dart';
import 'package:flutter_connection/bloc/internetbloc/internet_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocConsumer<Internetbloc, InternetState>(
              listener: (context, state) {
                if (state is InternetBackState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Internet connected",
                    ),
                    backgroundColor: Colors.green,
                  ));
                } else if (state is InternetlostState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Internet NOT connected",
                    ),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              builder: (context, state) {
                if (state is InternetBackState) {
                  return Text("COnnected");
                } else if (state is InternetlostState) {
                  return Text("Internet Lost");
                } else {
                  return Text("Loading...");
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Add your onPressed code here!
        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.amber,
      ),
    );
  }
}
