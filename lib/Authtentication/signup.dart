import 'package:buku_diary/Authtentication/login.dart';
import 'package:buku_diary/JsonModels/users.dart';
import 'package:buku_diary/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView to have an scrol in the screen
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("lib/assets/bg.png"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //We will copy the previous textfield we designed to avoid time consuming
        
                    Image.asset(
                      "lib/assets/login.png",
                      width: 300,
    
                    ),
                    
                    
                    
        
                    //As we assigned our controller to the textformfields
        
                    Container(
                      margin: EdgeInsets.all(8),
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
        
                    //Confirm Password field
                    // Now we check whether password matches or not
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      child: TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password is required";
                          } else if (password.text != confirmPassword.text) {
                            return "Passwords don't match";
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
        
                    const SizedBox(height: 80),
                    //Login button
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * .9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color.fromARGB(255, 255, 88, 88)),
                      child: TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //Login method will be here
        
                              final db = DatabaseHelper();
                              db
                                  .signup(Users(
                                      usrName: username.text,
                                      usrPassword: password.text))
                                  .whenComplete(() {
                                //After success user creation go to login screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              });
                            }
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
        
                    //Sign up button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?",
                        style: TextStyle(color: Colors.yellow),
                        ),
                        
                        TextButton(
                            onPressed: () {
                              //Navigate to sign up
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                            child: const Text("Login",
                            style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
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
