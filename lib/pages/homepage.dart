import 'package:database_app/database/database_helper.dart';
import 'package:database_app/pages/add_student.dart';
import 'package:database_app/pages/edit_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqlite_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DATABASE APP'),
        actions: [
          IconButton(
              onPressed: () async {
                var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => AddStudent(),
                    ));
                if (result == 'success') {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Map>>(
        future: DatabaseHelper().getAllStudents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  Map? student = snapshot.data?[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        child: Text(student?['id'].toString() ?? ''),
                      ),
                      ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Name'),
                          subtitle: Text(student?['name'] ?? ''),
                          // subtitle: Text(student?['phone']??''),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                             onPressed: () async{
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => updateStudent(
                                          id: student?['id'],
                                          name: student?['name'],
                                          address: student?['address'],
                                          phone: student?['phone'],
                                          email: student?['email']??'')
                                      ));
                              if(result !=null && result == 'success'){
                                setState(() {
                                  
                                });
                              };
                            },
                          )),
                      ListTile(
                        leading: const Icon(Icons.location_city),
                        title: const Text('City'),
                        subtitle: Text(student?['address'] ?? ''),
                        trailing: IconButton(
                          onPressed: () async{
                            var result = await databaseHelper.deleteStudent(student?['id']);
                            setState(() {
                              
                            });
                          },
                          icon: const Icon(Icons.delete)),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Phone'),
                        subtitle: Text(student?['phone'] ?? ''),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email'),
                        subtitle: Text(student?['email'] ?? ''),
                      ),
                    ],
                  );
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
          
          
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
