import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swifty_companion/ApiCall.dart';
import 'package:swifty_companion/display_info.dart';
import 'dart:convert';

import 'package:swifty_companion/hive_helper.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _login = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();
  bool _isLoading = false;

  void _onSubmit() async {
    print('is clicked');
  // Close the keyboard
  FocusScope.of(context).unfocus();
  
  // Your existing submit logic here
    try {
      if (formState.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        final data = await ApiCall.getUserByLogin(_login.text.trim(), context);
        if (data != null) {
          _login.text = "";
          // Navigate to a new screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DisplayInfo(userData: data,)),
          );
        }
      }
    } catch (e) {
      String errorString = e.toString();

      // Extract just the reason phrase after the colon and space
      if (errorString.contains(':')) {
        List<String> parts = errorString.split(': ');
        if (parts.length >= 3) {
          String reasonPhrase = parts[2]; // Gets the part after "statusCode: "
          print('Reason: $reasonPhrase');

          if (reasonPhrase.contains('Not Found')) {
            print('User not found');
          }
        }
      }

      print('Full error: $errorString');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.person_search_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                '42 Student Search',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),

                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  // border: Border.all(width: 1, color: Colors.white),
                ),
                child: Form(
                  key: formState,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _login,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please fill the login';
                          }
                          if (value.length < 4) {
                            print('im here');
                            return 'Login too short ${value.length} characters';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),

                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          hintText: 'enter login',
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                        ),
                      ),
                      SizedBox(height: 30),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _isLoading = false;
                      //     });
                      //   },
                      //   child: Text(
                      //     "click",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      IgnorePointer(
                        ignoring: _isLoading,
                        child: InkWell(
                          onTap: _onSubmit,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),

                            decoration: BoxDecoration(
                              color:
                                  _isLoading
                                      ? Colors.orange.withOpacity(0.5)
                                      : Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                _isLoading
                                    ? Center(
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.orangeAccent,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                    : Text(
                                      'Search',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                          ),
                        ),
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
  }
}
