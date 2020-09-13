import 'package:flutter/material.dart';
import 'package:goodwill_sept11/accounts/my_scaffold.dart';
import 'package:goodwill_sept11/transaction/search_screen.dart';
import 'package:goodwill_sept11/transaction/transaction_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      drawer: Drawer(
        child: Container(
          color: Colors.yellow[200],
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              CircleAvatar(
                  child: Image.asset("images/inn5.jpeg"), radius: 100.0),
              SizedBox(height: 20.0),
              IconButton(
                  iconSize: 50.0, icon: Icon(Icons.settings), onPressed: () {}),
              SizedBox(height: 20.0),
              CircleAvatar(
                child: Image.asset("images/mkt.png"),
                radius: 50.0,
              ),
              SizedBox(height: 20.0),
              IconButton(
                  iconSize: 50.0,
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_drop_down_circle_outlined),
              onPressed: () {}),
        ],
        centerTitle: true,
        toolbarHeight: 100.0,
        title: Text(
          widget.title,
          style: TextStyle(
              color: Colors.yellowAccent,
              fontFamily: "Pacifico",
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyScaffold()),
              );
            },
            child: Container(
              color: Colors.yellow[100],
              height: 200,
              width: 200,
              child: SizedBox(
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        "       new account",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Pacifico",
                            color: Colors.teal[900],
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Image.asset("images/account.png"),
                  ],
                ),
                height: 200.0,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionPage()),
              );
            },
            child: Container(
              color: Colors.green[100],
              height: 200,
              width: 200,
              child: SizedBox(
                child: Stack(
                  children: <Widget>[
                    Center(child: Text("transactions")),
                    Image.asset("images/piggy.gif"),
                    Container(
                      color: Colors.black12,
                      child: Center(
                          child: Text(
                        "                      transactions",
                        style:
                            TextStyle(fontFamily: "Pacifico", fontSize: 30.0),
                      )),
                    ),
                  ],
                ),
                height: 150.0,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.person_search_outlined,
          size: 50.0,
        ),
        onPressed: () {
          showSearch(
            context: context,
            delegate: AccountSearch(),
          );
        },
      ),
    );
  }
}
