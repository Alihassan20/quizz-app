import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_menu.dart';


class ResultScreen extends StatefulWidget {
  int score;
  List<String> name ;
  ResultScreen(this.score,this.name, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView.builder(
        physics:const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const  SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Congratulations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const  SizedBox(height: 45.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          const Text(
                            "Player Name",
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.name[index],
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],),
                        Column(
                          children: const[
                            Text(
                              "Level",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "easy",
                              style:  TextStyle(
                                color: Colors.green,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              "You Score is",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "${widget.score}",
                              style:const  TextStyle(
                                color: Colors.green,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                      ]),
                ),
                const SizedBox(height: 100.0),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  MainMenu(),
                        ));
                  },
                  shape: StadiumBorder(),
                  color: Colors.black54,
                  padding: const EdgeInsets.all(18.0),
                  child:const  Text(
                    "Reapeat the quizz",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}