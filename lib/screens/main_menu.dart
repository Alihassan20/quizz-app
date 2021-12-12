import 'package:flutter/material.dart';
import 'package:quiz/screens/quizz_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu( {Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}
String dropdownValue = 'Easy';
final textController = TextEditingController();

class _MainMenuState extends State<MainMenu> {
List<String> name = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Quiz App",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 150),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        focusedBorder:const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Colors.black)),

                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Enter Your Name",
                        hintStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        prefixIcon: const Icon(Icons.person)),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width:200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16)
                    ),
                    child: DropdownButton<String>(
                      dropdownColor:Colors.white70 ,
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      style:const  TextStyle(color: Colors.black),
                      underline: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      onChanged: ( newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Easy', 'Medium', 'Difficult']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                              width: 170,
                              child: Text(value)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: RawMaterialButton(
                    onPressed: () {
                      name.add(textController.text);
                      //Navigating the the Quizz Screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  QuizzScreen(name),
                          ));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    fillColor: Colors.black54,
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        "Start the Quiz",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
        ],
      ),
    );
  }
}