import 'dart:ui';
import 'package:e_commerce_real/model/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 168, 167, 167),
          ),
          Column(
            children: [
              Image.asset(
                'assets/intro.png',
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
              ),
              Align(
                alignment: const AlignmentDirectional(3, -1.5),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kprimaryColor.withOpacity(0.65),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -1.5),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.ksecondaryColor.withOpacity(0.65),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            right: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                    alignment: Alignment.bottomCenter,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.9),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 200,
            child: Column(
              children: [
                Text(
                  'Sign In',
                  style: GoogleFonts.signika(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    "Login to your account and explore our latest offerings.",
                    style: GoogleFonts.signika(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    cursorWidth: 1,
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      labelText: 'Email',
                      prefixIcon: Icon(Ionicons.mail_outline),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // Handle email input
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Ionicons.lock_closed_outline),
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                    obscureText: _obscureText,
                    onChanged: (value) {
                      // Handle email input
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.45, top: 10),
                  child: InkWell(
                      onTap: () {},
                      child: Text('forget your password?',
                          style: GoogleFonts.signika(
                            color: const Color.fromARGB(255, 0, 92, 185),
                            fontSize: 15,
                          ))),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(
                          Size(MediaQuery.of(context).size.width * 0.8, 50)),
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.transparent),
                      side: MaterialStatePropertyAll(BorderSide(
                          color: const Color.fromARGB(255, 235, 77, 20)))),
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: GoogleFonts.signika(
                        color: AppColors.backColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1,
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: GoogleFonts.signika(
                          color: AppColors.textPrimary,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {},
                          child: Text('Resgister here !',
                              style: GoogleFonts.signika(
                                color: const Color.fromARGB(255, 0, 78, 155),
                                fontSize: 15,
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Or continue with :',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.35,
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.logo_google,
                            size: 40,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.logo_facebook,
                            size: 40,
                          )),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
