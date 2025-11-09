import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              //back button
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.arrow_back,size: 35,
                    color: Colors.black,),
                ),
              ),

              //left side item
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(width: size.width/1.5,
                      margin: EdgeInsets.only(left: 15,bottom: 15),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("Hi how are you.",
                        style: TextStyle(color: Colors.white),))
                ],
              ),
              //right side item
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(width: size.width/1.5,
                      margin: EdgeInsets.only(left: 15,bottom: 15,right: 15),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Text("Hey mate,",
                        style: TextStyle(color: Colors.white),))
                ],
              ),

            ],
          ),
          //Textfield
          Container(
            color: Colors.black26,
            child: Row(
              children: [
                Container(
                  width: size.width/1.2,
                  padding: EdgeInsets.only(left: 15),
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white,),
                    maxLines: 1,
                    onSubmitted: (var abc){
                    },
                    onEditingComplete: (){
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.send,color: Colors.white,size: 25,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}