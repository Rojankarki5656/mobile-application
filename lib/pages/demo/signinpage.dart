import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signinpage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SigninpageState();
  }
}
class SigninpageState extends State<Signinpage>{
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
            Icon(Icons.person,color: Colors.black,size: 150,),
            Container(
              padding: EdgeInsets.all(20),
              //  height: size.height/4,
              width: size.width/1.2,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Signin",style: TextStyle(color: Colors.white,fontSize: 25,
                      fontWeight: FontWeight.bold),),
                  Container(
                    // height: 60,
                    width: size.width/1.4,
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Text("Email/Phone Number"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: size.width/1.4,
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Text("Password"),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.only(left: 25,right: 25,top: 15,bottom: 15),
                    color: Colors.blue,
                    child: Text("Login",style: TextStyle(color: Colors.white),),
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