import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final txtName = TextEditingController();
  final txtEmail = TextEditingController();
  final txtDOB = TextEditingController();
  final txtPhone = TextEditingController();

  var contactList = [
    "In-Person",
    "Email",
    "Voice Call",
    "Text Message",
  ];

  String? selectedContact = "Email";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("My Cool Game Beta Signup Form"),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                child: Container(
                  height: 150,
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    infoText,
                    style: TextStyle(fontSize: 17)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.person, size: 50,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text("Name"),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              txtName.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        controller: txtName,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),        
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.mail, size: 50,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text("Email"),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              txtEmail.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        controller: txtEmail,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                  ],
                ),        
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.calendar_month, size: 50,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text("Date of Birth"),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              txtDOB.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        controller: txtDOB,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),        
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.phone, size: 50,),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: Text("Phone"),
                          fillColor: Colors.white,
                          filled: true,
                          suffixIcon: IconButton(
                            onPressed: () {
                              txtPhone.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        controller: txtPhone,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),        
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(Icons.contact_support, size: 50,),
                    ),
                    Expanded(
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: DropdownButton(
                          isExpanded: true,
                          items: contactList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          value: selectedContact,
                          onChanged: (selected) {
                            setState(() {
                              selectedContact = selected;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),        
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        infoText = "";
                        txtName.clear();
                        txtEmail.clear();
                        txtDOB.clear();
                        txtPhone.clear();
                        selectedContact = "Email";
                      });
                    },
                    label: Text("Reset Form"),
                    icon: Icon(Icons.clear, size: 30, color: Colors.white),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ), 
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        infoText = "Name: ${txtName.text}\nEmail: ${txtEmail.text}\nDOB: ${txtDOB.text}\nPhone: ${txtPhone.text}\nContact Pref: $selectedContact";
                      });
                    },
                    label: Text("Submit Form"),
                    icon: Icon(Icons.check, size: 30, color: Colors.white),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue[900]),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
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
}