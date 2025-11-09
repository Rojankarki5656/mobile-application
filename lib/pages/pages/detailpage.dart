import 'package:flutter/material.dart';
import 'package:lab2nd/api/NewsApiCall.dart';
import 'package:lab2nd/core/static.dart';
import 'package:lab2nd/model/newsapi.dart';

class detailpage extends StatefulWidget {
  const detailpage({super.key});

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  verticalCard (size, heading, date, String url, actionbutton, Articles? article){
    return GestureDetector(
      onTap: (){

        StaticValue.clickedarticle = article;
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => detailpage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 15,top: 15),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black12
                  ),
                  // margin: EdgeInsets.only(left: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(url,
                      fit: BoxFit.cover,),
                  ),
                ),
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
                Positioned(
                    left: 50,
                    top: 25,
                    child: Icon(Icons.play_circle,color: Colors.white,size: 40,))
              ],
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width/2,
                  child: Text(heading,
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,fontSize: 20),
                    overflow: TextOverflow.visible
                    ,maxLines: 2,),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        actionbutton,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 15,),
                    Text(date,
                      style: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.bold,fontSize: 12),),
                  ],
                )

              ],
            )

          ],
        ),
      ),
    );
  }
  headerElement(size){
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: size.height/3.5,
              width: size.width,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadiusGeometry.circular(15),
                  color: Colors.black12
              ),
              // margin: EdgeInsets.only(left: 10),
              child: Image.network(StaticValue.clickedarticle!.urlToImage!,
                fit: BoxFit.cover,
              ),

            ),
            Container(
              height: size.height/3.5,
              width: size.width,
              // color: Colors.red,
              child: Center(
                child: Icon(Icons.play_circle, color: Colors.white, size: 50,),
              ),
            ),
            Positioned(
                left: 15, top: 15,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back, color: Colors.white, size: 40,))
            ),
            Positioned(
                right: 15, top: 15,
                child: Icon(Icons.share, color: Colors.white, size: 40,)
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(StaticValue.clickedarticle!.title!.toUpperCase(),
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,),
        ),
        Container(
          width: size.width,
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Row(
            children: [
              Text(StaticValue.clickedarticle!.author!),
              Text(StaticValue.clickedarticle!.publishedAt!.split("T")[0].toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text( StaticValue.clickedarticle!.description!,
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),
            overflow: TextOverflow.visible,),
        ),
      ],
    );
  }

  Future<newsapi?>? _futurenewsapicalldata;
  @override
  void initState() {
    super.initState();
    apicall();
  }
  apicall(){
    _futurenewsapicalldata = NewsApiCall().getnewsdata();
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 45,),

              //Header Element
              headerElement(size),
              FutureBuilder(
                  future: _futurenewsapicalldata,
                  builder: (context, AsyncSnapshot<newsapi?> snapshot) {
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.active:
                      case ConnectionState.waiting:
                      case ConnectionState.done:
                        if(snapshot.hasData){
                          newsapi data = snapshot.data!;
                          List<Articles> articles = data.articles!;
                          return Container(
                            height: size.height/1.4,
                            child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                scrollDirection: Axis.vertical,
                                itemCount: articles.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return verticalCard(size, articles[index].title,
                                      articles[index].publishedAt,
                                      articles[index].urlToImage!,
                                      articles[index].source!.name!,
                                      articles[index]);
                                }
                            ),
                          );
                        }else{
                          return Text("No Data Available");
                        }}
                    // By default, show a loading spinner
                    return const Center(child: CircularProgressIndicator());
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
