import 'package:database_app/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';

import '../modle/student.dart';

class updateStudent extends StatefulWidget {
  const updateStudent({required this.id, required this.name, required this.address, required this.phone, required this.email});
  final int id;
  final String name;
  final String address;
  final String phone;
  final String email;

  @override
  State<updateStudent> createState() => _updateStudentState();
}

class _updateStudentState extends State<updateStudent> {
  GlobalKey<FormState> _key = GlobalKey();
  DatabaseHelper databaseHelper = DatabaseHelper();
  String? name,address,phone,email;
  int? id;
  @override
  void initState() {
    id = widget.id;
    name = widget.name;
    address = widget.address;
    phone = widget.phone;
    email = widget.email;
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Student'),
      ),
      body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              const Text('Name'),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: name,
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
                initialValue: address,
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
                initialValue: phone,
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
                initialValue: email,
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
                    int result =await databaseHelper.updateStudent(
                      Student().insertStudent(
                        name: name ?? '',
                        address: address ?? '',
                        email: email ?? '',
                        phone: phone ?? ''
                      ),
                    id!,
                    );
                    print(result);
                  Navigator.pop(context,'success');
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Save'),
              )
            ],
          )),
    );
  }
}