// ignore_for_file: library_private_types_in_public_api

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shalom_mess/auth/auth.dart';
// import 'package:shalom_mess/helper/sharedpreference.dart';
// import 'package:shalom_mess/screen/addstudent.dart';
// import 'package:shalom_mess/screen/login_signup.dart';

// class BottomNavigatorScreen extends StatefulWidget {
//   const BottomNavigatorScreen({
//     super.key,
//   });

//   @override
//   State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
// }

// TextEditingController searcheditingcontroller = TextEditingController();
// final formsearchkey = GlobalKey<FormState>();
// ValueNotifier<RangeValues> ageRange = ValueNotifier(const RangeValues(0, 50));

// class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       color: const Color(0XFF188F79),
//       child: SafeArea(
//         child: Scaffold(
//           body: Column(
//             children: [
//               Container(
//                 color: const Color(0XFF188F79),
//                 padding: const EdgeInsets.all(10),
//                 width: size.width,
//                 child: Form(
//                     key: formsearchkey,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                             width: size.width / 1.3,
//                             child: TextFormField(
//                               onChanged: (value) {
//                                 setState(() {});
//                               },
//                               controller: searcheditingcontroller,
//                               decoration: const InputDecoration(
//                                 label: Text('Search'),
//                                 prefixIcon: Icon(Icons.search),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color(0XFF188F79),
//                                     ),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5))),
//                                 border: OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5))),
//                               ),
//                             )),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.exit_to_app,
//                             size: 30,
//                             color: Colors.white,
//                           ),
//                           onPressed: () {
//                             showDialog(
//                               barrierDismissible: false,
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: const Text("Logout"),
//                                   content: const Text(
//                                       "Are you sure you want to logout?"),
//                                   actions: [
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0Xff188F79)),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: const Text("cancel"),
//                                     ),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                           backgroundColor:
//                                               const Color(0Xff188F79)),
//                                       onPressed: () async {
//                                         await SharedpreferenceClass
//                                             .saveUserLoggedInStatus(false);
//                                         AuthServiceclass authService =
//                                             AuthServiceclass();
//                                         authService.signOut().whenComplete(
//                                               () => Navigator.of(context)
//                                                   .pushAndRemoveUntil(
//                                                 // the new route
//                                                 MaterialPageRoute(
//                                                   builder:
//                                                       (BuildContext context) =>
//                                                           const LoginScreen(),
//                                                 ),

//                                                 (Route route) => false,
//                                               ),
//                                             );
//                                       },
//                                       child: const Text("Yes"),
//                                     )
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                         )
//                       ],
//                     )),
//               ),
//               const AgeRangeSlider(),
//               ValueListenableBuilder<RangeValues>(
//                   valueListenable: ageRange,
//                   builder: (context, agerange, child) {
//                     return StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(FirebaseAuth.instance.currentUser!.uid)
//                           .collection('usercollection')
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (snapshot.hasError) {
//                           return Text('Error: ${snapshot.error}');
//                         } else if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         } else {
//                           var documents = snapshot.data!.docs;
//                           var filteredDocuments = documents
//                               .where((document) =>
//                                   document['name'].toLowerCase().contains(
//                                       searcheditingcontroller.text
//                                           .toLowerCase()) &&
//                                   document['age'] >= agerange.start.toInt() &&
//                                   document['age'] <= agerange.end.toInt())
//                               .toList();
//                           return Expanded(
//                             child: filteredDocuments.isNotEmpty
//                                 ? ListView.separated(
//                                     itemCount: filteredDocuments.length,
//                                     itemBuilder: (context, index) {
//                                       var documentData =
//                                           filteredDocuments[index].data()
//                                               as Map<String, dynamic>;
//                                       var studentName = documentData['name'];
//                                       var studentAge = documentData['age'];
//                                       var studentImage =
//                                           documentData['imageurl'];
//                                       return ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundImage:
//                                               NetworkImage(studentImage),
//                                         ),
//                                         title: Text(studentName),
//                                         subtitle: Text('Age: $studentAge'),
//                                       );
//                                     },
//                                     separatorBuilder: (context, index) =>
//                                         const SizedBox(height: 7),
//                                   )
//                                 : const Center(
//                                     child: Text('User Not Found'),
//                                   ),
//                           );
//                         }
//                       },
//                     );
//                   })
//             ],
//           ),
//           floatingActionButton: Align(
//             alignment: Alignment.bottomCenter,
//             child: FloatingActionButton.extended(
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => const AddStudentScrn(),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.add),
//               label: const Text('Add Student'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AgeRangeSlider extends StatefulWidget {
//   const AgeRangeSlider({super.key});

//   @override
//   _AgeRangeSliderState createState() => _AgeRangeSliderState();
// }

// class _AgeRangeSliderState extends State<AgeRangeSlider> {
//   RangeValues _currentRangeValues = const RangeValues(0, 50);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           'Age Range: ${_currentRangeValues.start.round()} - ${_currentRangeValues.end.round()}',
//           style: const TextStyle(fontSize: 16),
//         ),
//         const SizedBox(height: 20),
//         RangeSlider(
//           values: _currentRangeValues,
//           min: 0,
//           max: 50,
//           divisions: 50,
//           labels: RangeLabels(
//             _currentRangeValues.start.round().toString(),
//             _currentRangeValues.end.round().toString(),
//           ),
//           onChanged: (RangeValues values) {
//             setState(() {
//               _currentRangeValues = values;
//               ageRange.value = values;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }
