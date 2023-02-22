// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/rendering/box.dart';

import 'firestore_helper.dart';
import 'usermodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _finderName = TextEditingController();
  final TextEditingController _finderEmail = TextEditingController();
  final TextEditingController _finderAddress = TextEditingController();
  final TextEditingController _finderPhone = TextEditingController();

  @override
  void dispose() {
    _finderName.dispose();
    _finderEmail.dispose();
    _finderAddress.dispose();
    _finderPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("firebase crud latest"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _finderName,
                  decoration: const InputDecoration(
                    labelText: "Enter Name",
                    hintText: "Your Name",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _finderEmail,
                  decoration: const InputDecoration(
                    labelText: "Enter Email",
                    hintText: "Your Email",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _finderAddress,
                  decoration: const InputDecoration(
                    labelText: "Enter Address",
                    hintText: "Your Address",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextFormField(
                  controller: _finderPhone,
                  decoration: const InputDecoration(
                    labelText: "Enter Phone",
                    hintText: "Your Phone",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        FirestoreHelper.addData(UserModel(
                          finderName: _finderName.text,
                          finderEmail: _finderEmail.text,
                          finderAddress: _finderAddress.text,
                          finderPhone: double.parse(_finderPhone.text),
                        ));
                      },
                      child: const Text('Elevated Button'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(fontSize: 20),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {},
                      child: const Text("Read"),
                    ),
                  ],
                ),
              ),
              StreamBuilder<List<UserModel>>(
                stream: FirestoreHelper.read(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    final finderData = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: finderData!.length,
                        itemBuilder: (context, index) {
                          final singleUser = finderData[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                    color: Colors.purple,
                                    shape: BoxShape.circle),
                              ),
                              title: Text("${singleUser.finderName}"),
                              subtitle: Text("${singleUser.finderPhone}"),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
