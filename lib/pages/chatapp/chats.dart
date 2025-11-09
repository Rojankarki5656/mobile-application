import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class chats extends StatefulWidget {
  const chats({super.key});

  @override
  State<chats> createState() => _chatsState();
}

class _chatsState extends State<chats> {
  late TextEditingController _controller;

  String chatId = "123";
  String currentId = "456";
  String otherUserId = "789";

  //Firebase FireStore
  sendMessage(String text) async {
    final ref = FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .doc();
    await ref.set({
      "senderId": currentId,
      "Text": text.trim(),
      "timeStamp": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    //Update
    await FirebaseFirestore.instance
    .collection("chats")
    .doc(chatId)
    .set({
      "lastMessage": text.trim(),
      "lastupdated": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<QuerySnapshot> getMessages(){
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Column(
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

                  //Stream Builder
                  StreamBuilder<QuerySnapshot>(
                      stream: getMessages(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }
                        if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
                          return Text("No data");
                        }
                        final messages = snapshot.data!.docs;
                        return Container(
                          width: size.width,
                          height: size.height,
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 10),
                              itemCount: messages.length,
                              itemBuilder: (context, index){
                                var msg = messages[index];
                                final isMe = msg["SenderId"] == currentId;
                                return isMe?
                                    //show right side
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
                                        child: Text( msg['text'],
                                          style: TextStyle(color: Colors.white),))
                                  ],
                                )
                                :
                                //show right side
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
                                        child: Text( msg["text"],
                                          style: TextStyle(color: Colors.white),))
                                  ],
                                )

                                ;
                              }
                          ),
                        );
                      }
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
                          sendMessage(abc);
                          setState(() {
                            _controller.clear();
                          });
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
        ),
      ),
    );
  }
}
