import 'package:flutter/material.dart';
import 'package:http/http.dart' as basheerhttp;
import 'dart:convert';
import 'dart:async';
import 'Model/Data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // steps
  // model class has all fields same as json api
  // then on Homepage class create future method with list of the model class
  // get json data using http, decode json data, create list array, add data on the listof using for loop, retrun the listof

  Future <List<DataModelClass>> getAllData () async {

    var apiLink = "https://jsonplaceholder.typicode.com/photos";
    var data = await basheerhttp.get(apiLink);
    // now we get all data from the api
    // decode the data to be able to use it

    var jsonData = json.decode(data.body);
    // now all our data is inside this jsonData
    // create a list to store all field that is inside Data model class
    List<DataModelClass>listOf=[];
    for (var i in jsonData)
      {
        // for each position i in jsonData fill the 4 properties

        DataModelClass dataInside = new DataModelClass(i["id"],i["title"],i["url"],i["thumbnailUrl"]);
        // and add it to the list we created
        listOf.add(dataInside);
      }
    return listOf;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Json Pasring A"),
        actions: <Widget> [
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: ()=> debugPrint("Search")),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: ()=> debugPrint("add")),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Basheer"),
                accountEmail: new Text("Raiqib"),
              decoration: new BoxDecoration(
                color: Colors.deepOrange
              ),
            ),
            new ListTile(
              title: new Text("First Page"),
              leading: new Icon(Icons.search, color: Colors.orange,),
              // now use on tab to close drawer , use pop to dismiss last action
              onTap: (){ Navigator.of(context).pop();},
            ),
            new ListTile(
              title: new Text("Second Page"),
              leading: new Icon(Icons.add, color: Colors.red,),
              // now use on tab to close drawer , use pop to dismiss last action
              onTap: (){ Navigator.of(context).pop();},
            ),
            new ListTile(
              title: new Text("Third Page"),
              leading: new Icon(Icons.title, color: Colors.purple,),
              // now use on tab to close drawer , use pop to dismiss last action
              onTap: (){ Navigator.of(context).pop();},
            ),
            new ListTile(
              title: new Text("Forth Page"),
              leading: new Icon(Icons.add, color: Colors.green,),
              // now use on tab to close drawer , use pop to dismiss last action
              onTap: (){ Navigator.of(context).pop();},
            ),
            new Divider(
              height: 5.0,
            ),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.close, color: Colors.red,),
              // now use on tab to close drawer , use pop to dismiss last action
              onTap: (){ Navigator.of(context).pop();},
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: new FutureBuilder(
              future: getAllData(),
              builder: (BuildContext c, AsyncSnapshot snapshot){
                if(snapshot.data == null)
                  {
                    return Center(
                      child: new Text("Loading"),
                    );
                  }
                else
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext c, int index){
                        return Card(
                          elevation: 10.0,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Image.network(snapshot.data[index].url,
                                height: 150.0,
                                width: 150.0,
                                fit: BoxFit.cover,
                              ),
                              new SizedBox(
                                height: 7.0,
                              ),
                              new Container(
                                margin: EdgeInsets.all(6.0),
                                height: 50.0,
                                child: new Row(
                                  children: <Widget>[
                                    new Container(
                                      child: new CircleAvatar(
                                        child: new Text(snapshot.data[index].id.toString()),
                                      ),
                                    ),
                                    new SizedBox(
                                      height: 10.0,
                                    ),
                                    new Container(
                                      width: 80.0,
                                      child: new Text(snapshot.data[index].title, maxLines: 1,style: TextStyle(color: Colors.red),),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },

                    );
              },
            ),


          ),
          new Container(
          margin: EdgeInsets.all(10.0),
          height: 300.0,
            child: new FutureBuilder(
            future: getAllData(),
            builder: (BuildContext c, AsyncSnapshot snapshot){
            if(snapshot.data == null)
            {
            return Center(
            child: new Text("Loading"),
            );
            }
            else
            {
            return ListView.builder(

              itemCount: 10,

              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext c, int index ){
                return Card(
                  elevation: 10.0,
                  child: new Row(
                    children: <Widget>[
                      new Image.network(snapshot.data[index+3].url,
                        height: 80.0,
                        width: 80.0,
                        fit: BoxFit.cover,
                      ),
                      new SizedBox(
                        height: 7.0,
                      ),
                      Container(
                          margin: EdgeInsets.all(20.0),
                          width: 180,
                        child:  Text(snapshot.data[index+3].title, maxLines: 2,style: TextStyle(color: Colors.red))
                      ),
                      new SizedBox(
                        height: 50.0,
                      ),
                      new Container(
                        margin: EdgeInsets.all(15.0),
                        child: new CircleAvatar(
                          child: new Text(snapshot.data[index+3].id.toString()),
                        ),
                      ),
                    ],
                  ),
                );

              },
            );


            }}
            ),


          ),

        ],
      ),
    );
  }
}
