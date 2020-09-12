import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../account_model/account.dart';
import 'package:goodwill_sept11/main.dart';
import 'package:goodwill_sept11/home/home_page.dart';
import 'package:goodwill_sept11/accounts/my_scaffold.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget _buildDivider() => const SizedBox(width: 10);
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
            double _balance = a.accountBalance;

            return InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  child: AlertDialog(
                    content: Column(
                      children: <Widget>[
                        Text("${a.accountName} ${a.accountNumber}"),
                        TextField(
                          decoration: InputDecoration(hintText: "amount"),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          controller: _controller,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("withdraw"),
                        onPressed: () {
                          setState(() {
                            _balance -= double.parse(_controller.text);
                            box.add(index);
                            _controller.clear();
                            Navigator.pop(context);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text("deposit"),
                        onPressed: () {
                          setState(() {
                            _balance += double.parse(_controller.text);
                            box.add(index);
                            _controller.clear();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
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
                    leading: Icon(Icons.person),
                    title: Row(
                      children: <Widget>[
                        Text(" ${a.accountName.toUpperCase()}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        _buildDivider(),
                        Text(
                          "${a.accountNumber}",
                          style: TextStyle(
                              fontSize: 23.0, color: Colors.blue[700]),
                        ),
                        _buildDivider(),
                        Text("balance: N")
                      ],
                    ),
                    trailing: Text(
                      "${a.accountBalance}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: _color(_balance)),
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
