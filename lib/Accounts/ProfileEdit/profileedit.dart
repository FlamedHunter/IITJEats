import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String _oldname = "This is the prewritten text.";
  String _newname = "";
  bool _isEditing = false;

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = _oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _textEditingController,
              enabled: _isEditing,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Enter the text',
              ),
              onChanged: (value) {
                setState(() {
                  _newname = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!_isEditing)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                    child: Text('EDIT'),
                  ),
                if (_isEditing)
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            _oldname = _newname;
                          });
                        },
                        child: Text('SAVE'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isEditing = false;
                            _newname = _oldname;
                          });
                        },
                        child: Text('CANCEL'),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToProfileEdit(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ProfileEdit()),
  );
}
