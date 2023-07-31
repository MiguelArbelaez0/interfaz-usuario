import 'dart:io';

import 'package:flutter/material.dart';

import '../../../data/models/user_data.dart';
import '../../../data/repository/user/user_repository.dart';
import '../../widgets/select_image_pop_up.dart';
import '../regsiter_view_model.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register>
    implements IRegisterViewModel, IUserRepository {
  final formKey = GlobalKey<FormState>();
  late RegisterViewModel registerViewModel;
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordContorller = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isFirstCall = false;

  XFile? filename;

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

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  List<XFile>? _imageFileList;
  dynamic _pickImageError;
  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    registerViewModel = RegisterViewModel(this);
    if (!isFirstCall) {
      // registerViewModel.getUser();
    }
    Widget sendImage = Image(
      image: AssetImage('assets/vector.png'),
    );
    if (filename == null) {
      sendImage = Image(
        image: AssetImage('assets/vector.png'),
      );
    } else {
      sendImage = Image.file(File(filename!.path));
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/onboarding_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: ListView(
                children: [
                  SizedBox(
                    height: 47,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                            fontFamily: 'Inter-Bold.ttf',
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Form(
                      key: formKey,
                      child: Container(
                        margin: EdgeInsets.only(left: 17, right: 17),
                        child: Column(
                          children: [
                            TextFormField(
                              //NAME
                              controller: nameController,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: "Nombre*",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Nombre',
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            TextFormField(
                              //LASTNAME
                              controller: lastnameController,
                              autofocus: true,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: "Apellido*",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Apellido',
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            //phone
                            TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintText: "Telefono",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.phone_android),
                                  labelText: 'Telefono'),
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            //EMAIL
                            TextFormField(
                              controller: emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: validateEmail,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),

                            //password
                            TextFormField(
                              controller: passwordContorller,
                              validator: (value) {
                                if (value == null)
                                  return 'Este campo es requerido';
                                return value.length < 3
                                    ? 'Mínimo de 8 caracteres'
                                    : null;
                              },
                              // keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: "Contraseña",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.password),
                                labelText: 'Contraseña',
                              ),
                            ),
                            SizedBox(
                              height: 19,
                            ),

                            //Confirm password
                            TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value == null)
                                  return 'Este campo es requerido';
                                return value.length < 3
                                    ? 'Mínimo de 8 caracteres'
                                    : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                hintText: " Confirmar Contraseña",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(Icons.password),
                                labelText: 'Confirmar Contraseña',
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),

                            Container(
                              child: Text(
                                'Agregar Foto',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 17.83,
                            ),
                            Container(
                              width: 131.67,
                              height: 128.33,
                              child: GestureDetector(
                                onTap: () {
                                  //_onImageButtonPressed(ImageSource.camer context: context);
                                  SelectImagePopUp selectImagePopUp;
                                  selectImagePopUp = SelectImagePopUp();
                                  selectImagePopUp.showImageDialog(context,
                                      (xFile) {
                                    setState(() {
                                      filename = xFile;
                                    });
                                  });
                                },
                                child: Container(
                                  child: sendImage,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 54,
                            ),

                            SizedBox(
                              width: 339,
                              height: 59,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: ElevatedButton(
                                  onPressed: () {
                                    UserData userData = UserData(
                                      nameController.text,
                                      lastnameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      passwordContorller.text,
                                    );

                                    registerViewModel.createUser(userData);
                                    // Navigator.pushNamed(context, "/login",
                                    //     arguments: userData);
                                  },
                                  child: Text(
                                    'REGISTRAR',
                                    style: TextStyle(
                                      fontFamily: 'Poppins ',
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 47,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onCreateComplete(UserData userData) {
    Navigator.pushNamed(context, "/login", arguments: userData);
    Fluttertoast.showToast(
        msg: "se ha regisrado con exito",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void onError(String error) {
    Fluttertoast.showToast(
        msg: "a ocurrido un error al registrase",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  void onGetUser(UserData userData) {
    // TODO: implement onGetUser
    print(
      userData.name,
    );
    isFirstCall = true;
    setState(() {
      nameController.text = userData.name;
      emailController.text = userData.email;
      phoneController.text = userData.mobile_phone;
      passwordContorller.text = userData.password;
    });
  }
}
