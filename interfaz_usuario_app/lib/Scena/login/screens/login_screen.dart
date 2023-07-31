import 'package:flutter/material.dart';

import '../../../data/models/login_data.dart';
import '../../../data/models/user_data.dart';
import '../../../data/repository/user_default/user_default.dart';
import '../view_model/login_view_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  UserData userData;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  LoginScreen(this.userData, {super.key});
}

class _LoginScreenState extends State<LoginScreen> implements ILoginViewModel {
  late LoginViewModel loginViewModel;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isFirstCall = false;

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Entere un email valido '
        : null;
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = widget.userData.email;
    passwordController.text = widget.userData.password;
    loginViewModel = LoginViewModel(this);
    loginViewModel = LoginViewModel(this);
    UserDefault userDefault = UserDefault();
    userDefault.getUser((userData) {
      Navigator.pushNamed(context, "/Loby");
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
            ),
            ListView(
              children: [
                SizedBox(
                  height: 43,
                ),
                Center(
                  child: Text(
                    'Autenticate',
                    style: TextStyle(
                        fontFamily: 'Inter-Bold.ttf',
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 29,
                ),
                Container(
                  margin: EdgeInsets.only(left: 18, right: 17),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validateEmail,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.grey[800],
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 19,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null) return 'Este campo es requerido';
                            return value.length < 3
                                ? 'Mínimo de 8 caracteres'
                                : null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[800],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              // borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "Contraseña",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(Icons.password),
                            labelText: 'Contraseña',
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 19, right: 17),
                          width: 339,
                          height: 59,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey),
                              ),
                              onPressed: () {
                                LoginData loginData = LoginData(
                                  emailController.text,
                                  passwordController.text,
                                );

                                loginViewModel.login(loginData);
                              },
                              child: Text(
                                'Ingresar',
                                style: TextStyle(
                                  fontFamily: 'Poppins ',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 19, right: 17),
                          width: 339,
                          height: 59,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, "/Register");
                              },
                              child: Text(
                                'REGISTRAR',
                                style: TextStyle(
                                  fontFamily: 'Poppins ',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: "no fue posible autenticarse",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void onCompleteLogin(UserData userData) {
    UserDefault userDefault = UserDefault();
    userDefault.saveUser(userData);
    Navigator.pushNamed(context, "/Loby");
  }
}
