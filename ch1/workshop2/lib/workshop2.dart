import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Database _database;
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _initDatabase();
    _fetchItems();
  }

  Future<void> _initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'items_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> _fetchItems() async {
    final List<Map<String, dynamic>> maps = await _database.query('items');
    setState(() {
      _items = List.generate(maps.length, (i) {
        return maps[i]['name'];
      });
    });
  }
  Future<void> _updateItem(int id) async {
    String newName = 'Updated Item'; // New name for the updated item
    await _database.update(
      'items',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchItems();
}


  Future<void> _addItem() async {
    await _database.insert(
      'items',
      {'name': 'New Item'},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _fetchItems();
  }

  Future<void> _deleteItem(int id) async {
    await _database.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchItems();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Example'),
        backgroundColor: Colors.orange,
        actions: [
          
          IconButton(
            
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _database.delete('items');
              _fetchItems();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items[index]),
            onTap: () => _deleteItem(index + 1),
            onLongPress: () => _updateItem(index + 1),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
