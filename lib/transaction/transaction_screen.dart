import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../account_model/account.dart';
import 'package:goodwill_sept11/main.dart';
import 'package:goodwill_sept11/home/home_page.dart';
import 'package:goodwill_sept11/accounts/my_scaffold.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({Key key}) : super(key: key);
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Box box = Hive.box<Account>(accountBoxName);

    return Scaffold(
        backgroundColor: Colors.yellow[100],
        appBar: AppBar(
          toolbarHeight: 70.0,
          centerTitle: true,
          title: Text(
            "transactions",
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.yellowAccent,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico"),
          ),
        ),
        body: ListView.builder(
          itemCount: box.length,
          itemBuilder: (context, index) {
            Account a = box.getAt(index);

            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  child: Container(
                    color: Colors.yellow[100],
                    height: 100,
                    width: 200,
                    child: AlertDialog(
                      actionsOverflowButtonSpacing: 10.0,
                      actionsPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      title: Text("transaction window"),
                      content: Column(
                        children: <Widget>[
                          Text("${a.accountName} ${a.accountNumber}"),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: "amount"),
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            controller: _controller,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          child: Text("withdraw"),
                          onPressed: () {
                            setState(() {
                              a.accountBalance -=
                                  double.parse(_controller.text);
                              Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);

                              _controller.clear();
                              Navigator.pop(context);
                            });
                          },
                        ),
                        SizedBox(width: 60.0),
                        RaisedButton(
                          color: Colors.green,
                          child: Text("deposit"),
                          onPressed: () {
                            setState(() {
                              a.accountBalance +=
                                  double.parse(_controller.text);
                                  Box<Account> accountBox =
                                  Hive.box<Account>(accountBoxName);
                              accountBox.putAt(index, a);
                                  

                                  

                              _controller.clear();
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.all(10.0),
                shadowColor: Colors.tealAccent,
                elevation: 15.0,
                color: Colors.teal[100],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListTile(
                    key: widget.key,
                    leading: Icon(Icons.person),
                    title: Text(" ${a.accountName.toUpperCase()}",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(a.accountNumber.toString()),
                    trailing: Text(
                      a.accountBalance.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: _color(a.accountBalance)),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

_color(double balance) {
  if (balance < 0) {
    return Colors.red[800];
  } else {
    return Colors.green[800];
  }
}
