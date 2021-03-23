import 'package:flutter/material.dart';

import './add_task_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Widget _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text('Task title'),
            subtitle: Text('Date 23.03.21 - High'),
            trailing: Checkbox(
              onChanged: (value) {
                print(value);
              },
              activeColor: Theme.of(context).primaryColor,
              value: true,
            ),
          ),
          Divider(
            height: 2.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 80),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My tasks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '1 of 10',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }
          return _buildTask(index);
          // return Container(
          //   margin: EdgeInsets.all(10.0),
          //   height: 100.0,
          //   width: double.infinity,
          //   color: Colors.red,
          // );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
