import 'package:flutter/material.dart';
import 'package:lab2nd/pages/chatapp/chats.dart';


class Conversations extends StatefulWidget {
  const Conversations({super.key});
  @override
  State<Conversations> createState() => _ConversationsState();
}
class _ConversationsState extends State<Conversations> {

  listitem(){
    return  GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => chats(),
          ),
        );
      },
      child: Container(
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network("www.google.com",
                  fit: BoxFit.cover,),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Season Maharjan"),
                Text("You have a new message.")
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Conversations"),
          ),
          // list items
          listitem(),
          listitem(),
          listitem(),
        ],
      ),
    );
  }
}