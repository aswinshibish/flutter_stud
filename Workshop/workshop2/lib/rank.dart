// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class RankScreen extends StatelessWidget {
//   const RankScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference students =
//         FirebaseFirestore.instance.collection('students');

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.blue[900],
//         title: const Text(
//           "Top Scorers",
//           style: TextStyle(color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: students
//             .orderBy('score', descending: true)
//             .limit(5) // Limit the query to the top 3 scores
//             .get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text('Error loading data.'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('No students found.'));
//           }

//           final topStudents = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: topStudents.length,
//             itemBuilder: (context, index) {
//               final student = topStudents[index];
//               final name = student['studentname'] ?? 'N/A';
//               final course = student['course'] ?? 'N/A';
//               final score = student['score'] ?? 'N/A';

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 elevation: 5,
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     backgroundColor: Colors.blue[700],
//                     child: Text(
//                       (index + 1).toString(),
//                       style: const TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   ),
//                   title: Text(name, style: const TextStyle(fontSize: 18)),
//                   subtitle: Text("Course: $course\nScore: $score"),
//                   trailing: Icon(
//                     Icons.star,
//                     color: index == 0
//                         ? Colors.yellow[700]
//                         : (index == 1 ? Colors.grey : Color(0xFFCD7F32)),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference students =
        FirebaseFirestore.instance.collection('students');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Top Scorers",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<QuerySnapshot>(
          future: students
              .orderBy('score', descending: true)
              .limit(5) // Limit the query to the top 5 scores
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data.'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No students found.'));
            }

            final topStudents = snapshot.data!.docs;

            return Column(
              children: topStudents.map((studentDoc) {
                final index = topStudents.indexOf(studentDoc);
                final student = studentDoc;
                final name = student['studentname'] ?? 'N/A';
                final course = student['course'] ?? 'N/A';
                final score = student['score'] ?? 'N/A';

                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('image/blue.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.blue[700],
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    course,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "Score: $score",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
