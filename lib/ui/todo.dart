import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final _controller = TextEditingController();
  void _saveTask() {
    final taskName = _controller.text;
    FirebaseFirestore.instance.collection("Tasks").add({"name": taskName});
    _controller.clear();
  }

  Widget _buildList(QuerySnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: ((context, index) {
          final doc = snapshot.docs[index];
          return Dismissible(
            key: Key(doc.id),
            background: Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text('Delete',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            onDismissed: ((direction) {
              FirebaseFirestore.instance
                  .collection("Tasks")
                  .doc(doc.id)
                  .delete();
            }),
            child: ListTile(title: Text(doc["name"])),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: "Enter task"),
              ),
            ),
            ElevatedButton(
              child: Text("Save"),
              onPressed: (() {
                _saveTask();
              }),
            ),
          ]),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Tasks").snapshots(),
              builder: ((context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return Expanded(child: _buildList(snapshot.data!));
              }))
        ]),
      ),
    );
  }
}
