import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTraslationScreen extends StatefulWidget {
  const LanguageTraslationScreen({super.key});

  @override
  State<LanguageTraslationScreen> createState() =>
      _LanguageTraslationScreenState();
}

class _LanguageTraslationScreenState extends State<LanguageTraslationScreen> {
  var languages = ['Urdu', 'English', 'Hindi', 'Arabic'];
  var orginalLanguage = 'From';
  var destinationLanguage = 'To';
  var output = '';
  TextEditingController languageController = TextEditingController();
  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Fail to translate';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return "en";
    } else if (language == 'Urdu') {
      return "ur";
    } else if (language == 'Hindi') {
      return "hi";
    } else if (language == 'Arabic') {
      return "ar";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff10223d),
      appBar: AppBar(
        backgroundColor: Color(0xff10223d),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Language Translator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        orginalLanguage = value!;
                      });
                    },
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      orginalLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.arrow_right_alt_outlined,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DropdownButton(
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.white),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Please enter your text.. ',
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2b3c5a)),
                    onPressed: () {
                      translate(
                          getLanguageCode(orginalLanguage),
                          getLanguageCode(destinationLanguage),
                          languageController.text);
                    },
                    child: Text(
                      'Trasnlate',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "\n$output",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
