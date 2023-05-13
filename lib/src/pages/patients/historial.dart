import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime _selectedDate = DateTime.now();
  late Stream<QuerySnapshot<Map<String, dynamic>>> _historyStream;

  @override
  void initState() {
    super.initState();
    _historyStream = FirebaseFirestore.instance
        .collection('history')
        .where('timestamp',
            isGreaterThan: Timestamp.fromDate(_selectedDate.subtract(Duration(days: 1))))
        .where('timestamp', isLessThan: Timestamp.fromDate(_selectedDate.add(Duration(days: 1))))
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2022),
                  lastDate: DateTime.now());
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                  _historyStream = FirebaseFirestore.instance
                      .collection('history')
                      .where('timestamp',
                          isGreaterThan: Timestamp.fromDate(
                              _selectedDate.subtract(Duration(days: 1))))
                      .where('timestamp',
                          isLessThan: Timestamp.fromDate(_selectedDate.add(Duration(days: 1))))
                      .snapshots();
                });
              }
            },
            child: Text(
              'Select Date',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _historyStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final historyData = snapshot.data!.docs[index].data();
                    return ListTile(
                      title: Text(
                        'Date: ${historyData['timestamp'].toDate().toString()}'),
                      subtitle: Text('Event: ${historyData['event']}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
