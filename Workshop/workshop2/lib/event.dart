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
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

class Events_Screen extends StatefulWidget {
  const Events_Screen({super.key});

  @override
  State<Events_Screen> createState() => _Events_ScreenState();
}

class _Events_ScreenState extends State<Events_Screen> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Disable landscape mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Re-enable all orientations when leaving this screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Events",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "image/appbar4.jpg"), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No images found.'));
          }

          final imageDocs = snapshot.data!.docs;
          _imageUrls =
              imageDocs.map((doc) => doc['imageUrl'] as String).toList();

          // Pre-cache all the images before displaying them
          _preCacheImages(context);

          return ListView.builder(
            itemCount: _imageUrls.length,
            itemBuilder: (context, index) {
              final imageUrl = _imageUrls[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _showImageDialog(context, imageUrl);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        height: 300, // Default height if something goes wrong
                        child: const Center(child: Text('Error loading image')),
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 300, // Maintain a consistent height for images
                      fadeInDuration: const Duration(
                          milliseconds: 200), // Fade effect for better UX
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Show the image in a popup dialog with blurred background
  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Blurred background
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Center(
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog on tap
                  },
                  child: InteractiveViewer(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Pre-cache all images to avoid loading while scrolling
  void _preCacheImages(BuildContext context) {
    for (String imageUrl in _imageUrls) {
      precacheImage(NetworkImage(imageUrl), context);
    }
  }
}