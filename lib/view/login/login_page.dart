import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify/constants/colors.dart';
import 'package:spotify/view/tab/tap.dart';
import 'payment_page.dart';
import '../../constants/AppConstants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoggedIn = false;
  var db;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  void loginUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(AppConstants.isLoggedInKey, true);
    setState(() {
      isLoggedIn = true;
    });
  }

  void logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  void login() async {
    final enteredUsername = usernameController.text;
    final enteredPassword = passwordController.text;

    try {
      final querySnapshot = await db.collection('users').where('username', isEqualTo: enteredUsername).get();
      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        if (userData['password'] == enteredPassword) {
          loginUser();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Tabs()),
          );
        } else {
          showInvalidCredentialsDialog();
        }
      } else {
        showInvalidCredentialsDialog();
      }
    } catch (error) {
      print('Error logging in: $error');
      showInvalidCredentialsDialog();
    }
  }

  void signUp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Up'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (passwordController.text == confirmPasswordController.text) {
                try {
                  final user = <String, dynamic>{
                    "username": usernameController.text,
                    "password": passwordController.text,
                  };

                  await db.collection("users").add(user);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                } catch (error) {
                  print('Error signing up: $error');
                  showSignUpErrorDialog();
                }
              } else {
                showPasswordMismatchDialog();
              }
            },
            child: const Text('Sign Up'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void loginAsGuest() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Tabs()),
    );
  }

  void showInvalidCredentialsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Credentials'),
        content: const Text('Please enter valid username and password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showPasswordMismatchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Passwords do not match.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showSignUpErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('Error signing up. Please try again later.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SizedBox(
          height: height,
          child: Stack(
            children: [
              Container(
                height: height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Image.asset('assets/images/logo2.png'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Millions of songs, free',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        height: height / 1.9,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Login Account',
                              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 22),
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                labelText: 'Email or Username',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SwitchListTile.adaptive(
                              activeColor: ColorConstants.primaryColor,
                              value: rememberMe,
                              onChanged: (bool value) {
                                setState(() {
                                  rememberMe = value;
                                });
                              },
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                'Remember me',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(31),
                                ),
                              ),
                              onPressed: login,
                              child: const Text(
                                'LOG IN',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: loginAsGuest,
                              child: const Text(
                                'Continue as Guest',
                                style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: signUp,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.pink),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.pink),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don’t have an account?',
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            'Sign up now',
                            style: TextStyle(color: ColorConstants.primaryColor, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 44),
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

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
