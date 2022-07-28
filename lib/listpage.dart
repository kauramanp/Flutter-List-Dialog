import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_list_dialog/expenseModel.dart';

class listPage extends StatefulWidget {
  const listPage({Key? key}) : super(key: key);

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> {
  List<ExpenseModel> expenseModel = [];

  final _expenseType = TextEditingController();
  final _expense = TextEditingController();

  Future<void> _showMyDialog(int itemPosition) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Expense'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Enter expense type'),
                TextField(
                  controller: _expenseType,
                ),
                Text('Enter expense'),
                TextField(
                  controller: _expense,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: expenseModel.length,
            itemBuilder: ((context, index) {
              var item = expenseModel[index];
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(item.expenseType)),
                      InkWell(
                        child: Icon(Icons.edit),
                        onTap: () {
                          _showMyDialog(index);
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text("Expense")),
                      Text(item.expense.toString())
                    ],
                  ),
                ],
              );
            })),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showMyDialog(-1);
            },
            child: Icon(Icons.add)));
  }
}
