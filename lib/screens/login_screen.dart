import 'package:flutter/material.dart';
import 'package:my_app/common/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),

            Text(
              "Sign in to continue your curated",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text("shopping experience", style: TextStyle(fontSize: 16)),
            SizedBox(height: 30),

            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email Address", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 15),
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: "Enter email",
                    icon: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Email with '@' is required ";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25),
                  Text("Password", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 15),
                  CustomTextFormField(
                    controller: _passwordController,
                    hintText: "Enter password",
                    icon: Icons.visibility_off,
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 107, 207),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          email = _emailController.text;
                          password = _passwordController.text;
                        }
                        setState(() {});
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
