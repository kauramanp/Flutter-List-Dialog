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

  Future<void> _showMyDialog(int itemPosition) async {
    TextEditingController _expenseType = TextEditingController();
    TextEditingController _expense = TextEditingController();
    if (itemPosition > -1) {
      _expenseType.text = expenseModel[itemPosition].expenseType;
      _expense.text = (expenseModel[itemPosition].expense).toString();
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Expense'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
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
              child: const Text('Add'),
              onPressed: () {
                if (_expenseType.text.isEmpty) {
                  return;
                }
                if (_expense.text.isEmpty) {
                  return;
                }
                if (itemPosition < 0) {
                  expenseModel.add(ExpenseModel(_expenseType.text.toString(),
                      double.parse(_expense.text.toString())));
                } else {
                  var tempExpense = ExpenseModel(_expenseType.text.toString(),
                      double.parse(_expense.text.toString()));
                  expenseModel[itemPosition] = tempExpense;

                  //    expenseModel.removeAt(itemPosition);
                }
                setState(() {});
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
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
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showMyDialog(-1);
            },
            child: Icon(Icons.add)));
  }
}
