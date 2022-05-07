import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/auth.dart';

// the design of this page was inspired by
// https://github.com/oguzhanmavii/Flutter_Firebase_Note_App/blob/main/firebase_app_web/lib/screens/signUp_page.dart

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String activePage = "sign_in";

  bool circular = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return activePage == "sign_in" ? signIn(context) : signUp(context);
  }

  Widget signIn(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textItem("Email", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _passwordController, true),
              const SizedBox(
                height: 15,
              ),
              colorButton("Sign In", () {
                context
                    .read<Auth>()
                    .login(_emailController.text, _passwordController.text)
                    .then((err) {
                  if (err != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(err.error),
                      ),
                    );
                  }
                });
              }),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "If you don't have an Account ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        activePage = "sign_up";
                      });
                    },
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Forgot Password ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUp(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _surnameController = TextEditingController();
    final TextEditingController _passwordAgainController =
        TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _linkedinController = TextEditingController();
    final TextEditingController _companyController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              textItem("Name", _nameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Surname", _surnameController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Email", _emailController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _passwordController, true),
              const SizedBox(
                height: 15,
              ),
              textItem("Password", _passwordAgainController, true),
              const SizedBox(
                height: 15,
              ),
              textItem("Phone", _phoneController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Linkedin", _linkedinController, false),
              const SizedBox(
                height: 15,
              ),
              textItem("Company", _companyController, false),
              const SizedBox(
                height: 15,
              ),
              colorButton("Sign Up", () {
                context
                    .read<Auth>()
                    .register(
                      _nameController.text,
                      _surnameController.text,
                      _emailController.text,
                      _passwordController.text,
                      phone: _phoneController.text,
                      linkedin: _linkedinController.text,
                      company: _companyController.text,
                    )
                    .then((err) {
                  if (err != null) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(err.error)));
                  }
                });
              }),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "If you already have an Account ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        activePage = "sign_in";
                      });
                    },
                    child: const Text(
                      " Sign In",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textItem(
      String name, TextEditingController controller, bool obsecureText) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obsecureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget colorButton(String name, Function submit) {
    return InkWell(
      onTap: () {
        setState(() {
          circular = true;
        });

        try {
          submit();
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        }

        setState(() {
          circular = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [
            Color(0xFFFD746C),
            Color(0xFFFF9068),
            Color(0xFFFD746C),
          ]),
        ),
        child: Center(
          child: circular
              ? const CircularProgressIndicator()
              : Text(name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
        ),
      ),
    );
  }
}
