import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../database/database_helper.dart';
import '../../models/customer.dart';
import 'search_page.dart';
import '../models/const.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Gender { male, female }

class _HomePageState extends State<HomePage> {
  Gender _gender = Gender.male;
  late BuildContext ctx;
  final _customerNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  void _searchPageNavigator() {
    Navigator.of(ctx).pushNamed(SearchPage.route);
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: ListView(children: [
        Container(
          margin: const EdgeInsets.all(15),
          child: const Text(
            'Using SQLite!',
            style: TextStyle(
                fontSize: Constant.textFieldFontSize,
                color: Constant.textFieldColor),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 25, 20, 0),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 30),
                  child: const Text(
                    'Customer Name',
                    style: TextStyle(
                        fontSize: Constant.textFieldFontSize,
                        color: Constant.textFieldColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: _customerNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red.shade600, width: 2.3)),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade600),
                      ),
                      enabled: true,
                    ),
                    validator: ((value) {
                      if (value == '') {
                        return 'Do not let the field blank!';
                      }
                      return null;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 25, 20, 20),
          child: Row(
            children: [
              Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.only(right: 43),
                  child: const Text(
                    'Email Address',
                    style: TextStyle(
                        fontSize: Constant.textFieldFontSize,
                        color: Constant.textFieldColor),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 100,
                  child: TextFormField(
                    controller: _emailAddressController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLines: 1,
                    decoration: InputDecoration(
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.red.shade600, width: 2.3)),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red.shade600),
                      ),
                      enabled: true,
                    ),
                    validator: ((value) {
                      if (value == '') {
                        return 'Do not let the field blank!';
                      } else if (EmailValidator.validate(value as String) ==
                          false) {
                        return 'Invalid email address!';
                      }
                      return null;
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 25, 20, 20),
          child: Row(children: [
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 41),
                child: const Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: Constant.textFieldFontSize,
                      color: Constant.textFieldColor),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 100,
                child: TextFormField(
                  controller: _phoneNumberController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  maxLines: 1,
                  decoration: InputDecoration(
                    errorBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.red.shade600, width: 2.3)),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.shade600),
                    ),
                    enabled: true,
                  ),
                  validator: ((value) {
                    if (value == '') {
                      return 'Do not let the field blank!';
                    }
                    return null;
                  }),
                ),
              ),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 25, 20, 100),
          child: Row(children: [
            Expanded(
              flex: 0,
              child: Container(
                margin: const EdgeInsets.only(right: 80),
                child: const Text(
                  'Gender',
                  style: TextStyle(
                      fontSize: Constant.textFieldFontSize,
                      color: Constant.textFieldColor),
                ),
              ),
            ),
            Transform.scale(
              scale: 1.5,
              child: Radio(
                  activeColor: const Color.fromRGBO(20, 142, 146, 1),
                  value: Gender.male,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  }),
            ),
            const Text('Male'),
            Transform.scale(
              scale: 1.5,
              child: Radio(
                  activeColor: const Color.fromRGBO(20, 142, 146, 1),
                  value: Gender.female,
                  groupValue: _gender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _gender = value!;
                    });
                  }),
            ),
            const Text('Female'),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper.instance.add(Customer(
                    name: _customerNameController.text,
                    emailAddress: _emailAddressController.text,
                    phoneNumber: _phoneNumberController.text,
                    gender: _gender.toString()));
                setState(() {
                  _customerNameController.clear();
                  _emailAddressController.clear();
                  _phoneNumberController.clear();
                  _gender = Gender.male;
                });
              },
              // null,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.shade200),
              child: const Text('ADD CUSTOMER'),
            ),
            ElevatedButton(
              onPressed: _searchPageNavigator,
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey.shade200),
              child: const Text('SEARCH CUSTOMER'),
            )
          ],
        ),
      ]),
    );
  }
}
