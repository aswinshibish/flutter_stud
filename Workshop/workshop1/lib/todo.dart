// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TodoListApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TodoListScreen(),
//     );
//   }
// }

// class TodoListScreen extends StatefulWidget {
//   @override
//   _TodoListScreenState createState() => _TodoListScreenState();
// }

// class _TodoListScreenState extends State<TodoListScreen> {
//   final TextEditingController _taskController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   @override
//   void dispose() {
//     _taskController.dispose();
//     super.dispose();
//   }

//   void _addTask() async {
//     if (_taskController.text.trim().isEmpty) return;

//     await _firestore.collection('todos').add({
//       'task': _taskController.text.trim(),
//       'completed': false,
//       'timestamp': FieldValue.serverTimestamp(),
//     });

//     _taskController.clear();
//   }

//   void _updateTask(String id, String newTask) async {
//     await _firestore.collection('todos').doc(id).update({'task': newTask});
//   }

//   void _toggleCompletion(String id, bool isCompleted) async {
//     await _firestore.collection('todos').doc(id).update({'completed': !isCompleted});
//   }

//   void _deleteTask(String id) async {
//     await _firestore.collection('todos').doc(id).delete();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("To-Do List"),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _taskController,
//                     decoration: const InputDecoration(
//                       hintText: "Enter a task",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: _addTask,
//                   child: const Text("Add"),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _firestore
//                   .collection('todos')
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return const Center(child: Text('No tasks found.'));
//                 }

//                 final todos = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: todos.length,
//                   itemBuilder: (context, index) {
//                     final doc = todos[index];
//                     final id = doc.id;
//                     final task = doc['task'];
//                     final completed = doc['completed'];

//                     return ListTile(
//                       leading: Checkbox(
//                         value: completed,
//                         onChanged: (_) => _toggleCompletion(id, completed),
//                       ),
//                       title: Text(
//                         task,
//                         style: TextStyle(
//                           decoration: completed ? TextDecoration.lineThrough : null,
//                         ),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.edit),
//                             onPressed: () {
//                               _showEditDialog(id, task);
//                             },
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.delete),
//                             onPressed: () {
//                               _deleteTask(id);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditDialog(String id, String oldTask) {
//     final TextEditingController editController =
//         TextEditingController(text: oldTask);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Edit Task"),
//           content: TextField(
//             controller: editController,
//             decoration: const InputDecoration(hintText: "Enter updated task"),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 final newTask = editController.text.trim();
//                 if (newTask.isNotEmpty) {
//                   _updateTask(id, newTask);
//                 }
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

