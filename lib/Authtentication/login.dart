import 'package:buku_diary/Authtentication/signup.dart';
import 'package:buku_diary/JsonModels/users.dart';
import 'package:buku_diary/SQLite/sqlite.dart';
import 'package:buku_diary/Views/notes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //We need two text editing controller

  //TextEditing controller to control the text when we enter into it
  final username = TextEditingController();
  final password = TextEditingController();

  //A bool variable for show and hide password
  bool isVisible = false;

  //Here is our bool variable
  bool isLoginTrue = false;

  final db = DatabaseHelper();

  //Now we should call this function in login button
  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      //If login is correct, then goto notes
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Notes()));
    } else {
      //If not, true the bool value to show error message
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  //We have to create global key for our form
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("lib/assets/bg.png"), 
            fit: BoxFit.cover,

            ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              //We put all our textfield to a form to be controlled and not allow as empty
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //Username field
                    //Before we show the image, after we copied the image we need to define the location in pubspec.yaml
                    Image.asset(
                      "lib/assets/logo.png",
                      width: 300,
                    ),
                    const SizedBox(height: 80),

                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      child: TextFormField(
                        controller: username,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username is required";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Username",
                        ),
                        
                      ),  
                    ),
                    //Password field
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          }
                          return null;
                        },
                        obscureText: !isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  //In here we will create a click to show and hide the password a toggle button
                                  setState(() {
                                    //toggle button
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
        
                    const SizedBox(height: 50),
                    //Login button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 238, 80, 94)),
                      child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //Login method will be here
                              login();
        
                              //Now we have a response from our sqlite method
                              //We are going to create a user
                            }
                          },
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                          )),
                    ),
        
                    //Sign up button
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.yellow), // Make the text white
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign up
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white), // Make the text white
                          ),
                        ),
                      ],
                    ),

        
                    // We will disable this message in default, when user and pass is incorrect we will trigger this message to user
                    isLoginTrue
                        ? const Text(
                            "Username or passowrd is incorrect",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
