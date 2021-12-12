import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/result_screen.dart';

import '../data/questions_example.dart';

class QuizzScreen extends StatefulWidget {
  List<String> name ;
   QuizzScreen(this.name) ;

  @override
  _QuizzScreenState createState() => _QuizzScreenState();
}

class _QuizzScreenState extends State<QuizzScreen> {
  int question_pos = 0;
  int score = 0;
  bool btnPressed = false;
  PageController? _controller;
  String btnText = "Skip >>";
  bool answered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: PageView.builder(
              controller: _controller!,
              onPageChanged: (page) {
                if (page == questions.length - 1) {
                  setState(() {
                    btnText = "See Results";
                  });
                }
                setState(() {
                  answered = false;
                });
              },
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Question ${index + 1}/10",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.black),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      height: 200.0,
                      child: Column(
                        children: [
                          Text(
                            "${questions[index].question}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                            ),
                          ),
                         const  SizedBox(height: 20),
                          const Text("Timer",style: TextStyle(fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TweenAnimationBuilder<Duration>(
                                  duration: const Duration(seconds: 10),
                                  tween: Tween(begin: const Duration(seconds: 10), end: Duration.zero),
                                  onEnd: () {
                                    if (_controller!.page!.toInt() ==
                                        questions.length - 1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ResultScreen(score,widget.name)));
                                    } else {
                                      _controller!.nextPage(
                                          duration: const Duration(milliseconds: 250),
                                          curve: Curves.easeInExpo);

                                      setState(() {
                                        btnPressed = false;
                                      });
                                    }
                                  },
                                  builder: (BuildContext context, Duration value, Widget? child) {
                                    final seconds = value.inSeconds;

                                    return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text('$seconds ',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30)));
                                  }),
                              const SizedBox(width: 5),
                              const Icon(Icons.timer,color: Colors.red,),
                            ],
                          ),
                        ],
                      ),
                    ),
                    for (int i = 0; i < questions[index].answers!.length; i++)
                      Container(
                        width: double.infinity,
                        height: 50.0,
                        margin: const EdgeInsets.only(
                            bottom: 15.0, left: 5.0, right: 5.0),
                        child: RawMaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          fillColor: btnPressed
                              ? questions[index].answers!.values.toList()[i]
                                  ? Colors.green
                                  : Colors.red
                              : Colors.grey,
                          onPressed: !answered
                              ? () {
                                  if (questions[index]
                                      .answers!
                                      .values
                                      .toList()[i]) {
                                    score++;
                                    print("yes");
                                  } else {
                                    print("no");
                                  }
                                  setState(() {
                                    btnPressed = true;
                                    answered = true;
                                  });
                                  _controller!
                                      .nextPage(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          curve: Curves.bounceInOut)
                                      .then((value) {
                                        if(index+1==10){
                                          setState(() {
                                            btnPressed = true;
                                          });
                                        }else{
                                          setState(() {
                                            btnPressed = false;
                                          });
                                        }
                                  });
                                }
                              : null,
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Text((i + 1).toString(),
                                  style: const TextStyle(fontSize: 18)),
                              const Text(" _", style: TextStyle(fontSize: 18)),
                              const SizedBox(width: 10),
                              Text(questions[index].answers!.keys.toList()[i],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 250),
                      child: RawMaterialButton(
                        onPressed: () {
                          if (_controller!.page!.toInt() ==
                              questions.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultScreen(score,widget.name)));
                          } else {
                            _controller!.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInExpo);

                            setState(() {
                              btnPressed = false;
                            });
                          }
                        },
                        shape: StadiumBorder(),
                        fillColor: Colors.grey,
                        padding: const EdgeInsets.all(15.0),
                        elevation: 0.0,
                        child: Text(
                          btnText,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: questions.length,
            )),
      ),
    );
  }
}
