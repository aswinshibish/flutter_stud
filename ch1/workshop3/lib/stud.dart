import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Flicker12 extends StatefulWidget {
  const Flicker12({Key? key}) : super(key: key);

  @override
  State<Flicker12> createState() => _FlickerState();
}

class _FlickerState extends State<Flicker12> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  List<ProfileModel> profiles = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    profiles = await ProfileDatabase().getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: () {
                ProfileDatabase().deleteAll();
                setState(() {});
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _mobileController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mobile number',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isEmpty) {
                print("Please enter a name.");
                return;
              }
              if (_mobileController.text.isEmpty) {
                print("Please enter a mobile number.");
                return;
              }

              final profile = ProfileModel(
                name: _nameController.text,
                mobile: int.tryParse(_mobileController.text) ?? 0,
              );

              _nameController.clear();
              _mobileController.clear();

              await ProfileDatabase().sendData(profile);

              fetchData();
            },
            child: Text("Add to server"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return ListTile(
                  title: Text(profile.name ?? ""),
                  subtitle: Text(profile.mobile != null ? "Mobile: ${profile.mobile}" : ""),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Key: ${profile.key ?? ""}'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Name: ${profile.name ?? ""}'),
                              SizedBox(height: 8),
                              Text('Mobile: ${profile.mobile ?? ""}'),
                            ],
                          ),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text('Update'),
                              onPressed: () {
                                Navigator.of(context).pop();

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController nameController = TextEditingController(text: profile.name);
                                    TextEditingController mobileController = TextEditingController(text: profile.mobile?.toString() ?? '');

                                    return AlertDialog(
                                      title: Text('Update Profile'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(labelText: 'Name'),
                                          ),
                                          SizedBox(height: 8),
                                          TextField(
                                            controller: mobileController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(labelText: 'Mobile number'),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: Text('Save'),
                                          onPressed: () {
                                            profile.name = nameController.text;
                                            profile.mobile = int.tryParse(mobileController.text);
                                            ProfileDatabase().updateData(profile);
                                            fetchData();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            ElevatedButton(
                              child: Text('Delete'),
                              onPressed: () {
                                Navigator.of(context).pop();

                                ProfileDatabase().deleteData(profile);
                                setState(() {
                                  fetchData();
                                });
                              },
                            ),
                          ],
                        );
                      },
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

class ProfileModel {
  ProfileModel({this.key, this.name, this.mobile});
  String? key;
  int? mobile;
  String? name;

  Map<String, dynamic> toMap() {
    return {"name": name, "mobile": mobile};
  }
}

class ProfileDatabase {
  DatabaseReference database() {
    return FirebaseDatabase.instance.ref().child("Profile Database");
  }

  Future<void> sendData(ProfileModel profile) async {
    try {
      final key = database().push().key!;

      await database().child(key).set(profile.toMap());
      print("Data added successfully with key: $key");
    } catch (error) {
      print("Error adding data: $error");
    }
  }

  Future<List<ProfileModel>> getData() async {
    var db = await FirebaseDatabase.instance.ref().child("Profile Database").once();
    Map<dynamic, dynamic> items = db.snapshot.value as Map<dynamic, dynamic>;
    List<ProfileModel> profiles = [];
    items.forEach((key, value) {
      profiles.add(
        ProfileModel(key: key, name: value["name"], mobile: value["mobile"]),
      );
    });
    return profiles;
  }

  Future<void> updateData(ProfileModel profile) async {
    try {
      if (profile.key != null) {
        await database().child(profile.key!).update(profile.toMap());
        if (kDebugMode) {
          print("Data updated successfully for key: ${profile.key}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error updating data: $error");
      }
    }
  }

  Future<void> deleteData(ProfileModel profile) async {
    await database().child(profile.key!).remove();
  }

  Future<void> deleteAll() async {
    await database().remove();
  }
}

