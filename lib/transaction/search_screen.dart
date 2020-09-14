import 'package:flutter/material.dart';
import 'package:goodwill_sept11/transaction/transaction_screen.dart';
import 'package:hive/hive.dart';

import '../account_model/account.dart';

List<Account> accountlist = List();
Box box = Hive.box<Account>(accountBoxName);

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //List<Account> accountlist = List();
    //Box box = Hive.box<Account>(accountBoxName);
    accountlist.addAll(box.values);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.search_rounded),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: AccountSearch(),
                );
              })
        ],
        centerTitle: true,
        title: Text("search sccounts"),
      ),
      body: ListView.builder(
        itemCount: accountlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(accountlist[index].accountName),
          );
        },
      ),
    );
  }
}

class AccountSearch extends SearchDelegate<Box> {
  // AccountSearch(this.accountlist);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  Widget selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TransactionPage()),
        );
      },
      child: selectedResult,
    );
  }

  //List<dynamic> listExample;
  List<Account> recentList = [];
  @override
  Widget buildSuggestions(BuildContext context) {
    accountlist.addAll(box.values);
    //List<Account> filterList = new List();
    List<Account> suggestionList = [];

    query.isEmpty
        ? suggestionList = accountlist
        : suggestionList.addAll(accountlist
            .where((element) => element.accountName.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${suggestionList[index].accountName}"),
          subtitle: Text("${suggestionList[index].accountNumber}"),
          trailing: Text("${suggestionList[index].accountBalance}"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (index) => TransactionPage()),
            );
            selectedResult = suggestionList[index].accountName as Widget;
            showResults(context);
          },
        );
      },
    );
  }
}
