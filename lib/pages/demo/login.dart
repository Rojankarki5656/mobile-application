import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return loginPageState();
  }

}

class loginPageState extends State<loginPage>{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Icon(Icons.person,size: 50,color: Colors.black,),
            ),
            Container(
              width: size.width/1.2,
              height: size.height/5,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white)

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Signin"),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    width: size.width/1.4,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Text("Phone"),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    width: size.width/1.4,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Text("Password"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("Login"),
                      ),
                    ],
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}