import 'package:flutter/material.dart';
import 'package:lab2nd/api/NewsApiCall.dart';
import 'package:lab2nd/core/static.dart';
import 'package:lab2nd/pages/pages/detailpage.dart';
import 'package:lab2nd/model/newsapi.dart';
import 'package:url_launcher/url_launcher.dart';


class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}
class _dashboardState extends State<dashboard> {

  Future<void> _launchInBrowser(Uri url) async{
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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

  horizontalCard(size, heading, date, String url){
    return Stack(
      children: [
        Container(
          height: size.height/5,
          width: size.width/1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12
          ),
          margin: EdgeInsets.only(left: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(url,
              fit: BoxFit.cover,),
          ),
        ),
        Container(
          height: size.height/5,
          width: size.width/1.5,
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black12
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 16),),
              Text(date,
                style: TextStyle(color: Colors.white,
                    fontSize: 14,fontWeight: FontWeight.normal),)
            ],
          ),
        ),
        Positioned(
              right: 15,
              bottom: 15,
              child: GestureDetector(
                  onTap: () => _launchInBrowser(Uri.parse(url)),
                  child: Icon(Icons.play_circle,color: Colors.white,size: 30,))
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
      //appBar: ,
      body: Column(
        children: [
          SizedBox(height: 60,),

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
                        height: size.height/5,
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            itemCount: articles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return horizontalCard(size, articles[index].title,
                                  articles[index].publishedAt,
                                  articles[index].urlToImage!);
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
    );
  }
}
