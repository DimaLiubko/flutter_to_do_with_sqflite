import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async {
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print('$_title, $_date $_priority');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColor,
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Add Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        initialValue: _title,
                        onSaved: (input) => _title = input,
                        validator: (input) => input.trim().isEmpty ? 'Please enter a task title' : null,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: TextFormField(
                        readOnly: true,
                        style: TextStyle(fontSize: 18.0),
                        controller: _dateController,
                        onTap: _handleDatePicker,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() => _priority = value);
                        },
                        items: _priorities.map((String priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(
                              priority,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 22.0,
                        iconEnabledColor: Theme.of(context).primaryColor,
                        style: TextStyle(fontSize: 18.0),
                        value: _priority,
                        validator: (input) => _priority == null ? 'Please select priority level' : null,
                        decoration: InputDecoration(
                          labelText: 'Priority',
                          labelStyle: TextStyle(fontSize: 18.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 60.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
