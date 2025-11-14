import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return loginpageState();
  }
}
class loginpageState extends State<loginpage>{
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
            Icon(Icons.person,size: 50,color: Colors.black,),
            Container(
              height: size.height/3,
              width: size.width/1.1,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Signin",style: TextStyle(color: Colors.white,fontSize: 20),),
                  Container(
                    width: size.width/1.2,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Text("Email/Phone Number"),
                  ),
                  Container(
                    width: size.width/1.2,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Text("Password"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.brown
                        ),
                        child: Text("Login",style: TextStyle(color: Colors.white),),
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