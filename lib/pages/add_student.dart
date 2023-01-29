import 'package:database_app/database/database_helper.dart';
import 'package:database_app/modle/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  GlobalKey<FormState> _key = GlobalKey();
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? name, address, phone, email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              const Text('Name'),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Enter Name',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              const Text('Address'),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Address';
                  }
                  return null;
                },
                onSaved: (value) {
                  address = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_city),
                    hintText: 'Enter Address',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              const Text('Phone'),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Phone';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Enter PhoneNumber',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              const Text('Email'),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter Email',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () async{
                  if (_key.currentState != null &&
                      _key.currentState!.validate()) {
                      _key.currentState?.save();
                    int id =await databaseHelper.insertStudent(Student().insertStudent(
                        name: name ?? '',
                        address: address ?? '',
                        email: email ?? '',
                        phone: phone ?? ''));
                        print(id);
                        Navigator.pop(context,'success');
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              )
            ],
          )),
    );
  }
}
