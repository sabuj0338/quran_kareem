import 'package:flutter/material.dart';
import 'package:ytquran/provider/ScheduleProvider.dart';
import 'package:ytquran/provider/SettingsProvider.dart';
import 'package:provider/provider.dart';

class RestoreConfirmationBottomSheet extends StatelessWidget {
  const RestoreConfirmationBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            "Are you sure?",
            style: TextStyle(fontSize: 18),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.close_outlined, color: Colors.redAccent),
          title: const Text('NO'),
          onTap: () async => Navigator.of(context).pop(),
        ),
        ListTile(
          leading: const Icon(Icons.done_outlined, color: Colors.greenAccent),
          title: const Text('YES'),
          onTap: () async {
            Provider.of<ScheduleProvider>(context, listen: false).restoreDB();
            Provider.of<SettingsProvider>(context, listen: false).refresh();
            final snackBar = SnackBar(
              content: Text('Reset completed!'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //Put your code here which you want to execute on Yes button click.
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
