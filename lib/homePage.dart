
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:card_swiper/card_swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _drinks = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/json/drinks.json');
    final data = await json.decode(response);

    setState(() {
      _drinks = data['drinks'];
    });
    print(_drinks);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Recipes', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.menu, color: Colors.grey[900],),
          onPressed: () {}
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(IconlyLight.search, color: Colors.grey[900],)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 600,
            child: Swiper(
              itemCount: _drinks.length,
              viewportFraction: 0.7,
              scale: 0.8,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(right:20, left: 20, top: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Column(
                    children: [
                      Text(_drinks[index]['name'], style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 10,),
                      Text(_drinks[index]['sub_name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),),
                      SizedBox(
                        height: 400,
                        child: Image.asset(_drinks[index]['image']),
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        children: [
                          const Icon(
                            IconlyLight.time_circle
                          ),
                          const SizedBox(width: 20,),
                          Text(_drinks[index]['time'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Icon(
                            Icons.thumb_up_off_alt_outlined
                          ),
                          const SizedBox(width: 20,),
                          Text(_drinks[index]['like'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}