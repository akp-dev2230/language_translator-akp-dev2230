import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslation extends StatefulWidget{
  @override
  State<LanguageTranslation> createState() => _LanguageTranslationState();
}

class _LanguageTranslationState extends State<LanguageTranslation> {

  var languages = ['Hindi', 'English', 'Arabic','French'];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async{
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src =='__' || dest == '__'){
      setState(() {
        output = "Fail to translate";
      });
    }
  }

  String getLanguageCode (String language){
    if(language =="Hindi"){
      return "hi";
    }else if(language == "English"){
      return "en";
    }else if(language == "Arabic"){
      return "ar";
    }else if(language == "French"){
      return "fr";
    }
    return "__";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Translator',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(focusColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  iconEnabledColor: Colors.white,
                  hint: Text(originLanguage,style: TextStyle(color: Colors.black),),
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                  items: languages.map((String dropDownStringItem){
                    return DropdownMenuItem(child: Text(dropDownStringItem),
                    value: dropDownStringItem,);
                  }).toList(),
                  onChanged: (String? value){
                    setState(() {
                      originLanguage = value!;
                    });
                  },
                  ),
                  SizedBox(width: 40,),
                  Icon(Icons.arrow_right_alt_outlined,color: Colors.black,size: 40,),
                  SizedBox(width: 40,),
                  DropdownButton(focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(destinationLanguage,style: TextStyle(color: Colors.black),),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                    items: languages.map((String dropDownStringItem){
                      return DropdownMenuItem(child: Text(dropDownStringItem),
                        value: dropDownStringItem,);
                    }).toList(),
                    onChanged: (String? value){
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: languageController,
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: TextStyle(fontSize: 15,color: Colors.black),
                  decoration: InputDecoration(
                    label: Text('Please enter your text..',style: TextStyle(color: Colors.black),),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    errorStyle: TextStyle(color: Colors.redAccent,fontSize: 15),
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter text to translate';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(onPressed: (){
                  translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
                },
                  child: Text('Translate',style: TextStyle(color: Colors.black),),
                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll<Color>(Colors.blueAccent.shade100)),
                ),
              ),
              SizedBox(height: 20,),
              Text('$output', style: TextStyle(color: Colors.black, fontSize: 20),),
            ],
          ),
        ),
      ),

    );
  }
}