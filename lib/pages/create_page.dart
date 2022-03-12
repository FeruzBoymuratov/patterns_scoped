import 'package:flutter/material.dart';
import 'package:patterns_scoped/scopes/home_scoped.dart';
import 'package:scoped_model/scoped_model.dart';

class CreatePage extends StatefulWidget {
  static const String id = 'create_page';
  const CreatePage({Key? key}) : super(key: key);
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  HomeScoped createScoped = HomeScoped();
  int newValue = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ScopedModel<HomeScoped>(
        model: createScoped,
        child: ScopedModelDescendant<HomeScoped>(
          builder: (context, child, model) {
            return Stack(
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Title ni kiriting!'),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      margin: const EdgeInsets.all(15),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: createScoped.titleController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text('Body ni kiriting!'),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      margin: const EdgeInsets.all(15),
                      width: double.infinity,
                      height: 50,
                      child: TextField(
                        controller: createScoped.bodyController,
                        decoration: const InputDecoration(
                          hintText: 'Body',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text('User ID ni tanlang!'),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height/2),
                      ),
                      width: double.infinity,
                      child: DropdownButton(
                        value: createScoped.dropdownValue,
                        items: [
                          DropdownMenuItem(
                            child: Text(1.toString()),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text(2.toString()),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text(3.toString()),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text(4.toString()),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Text(5.toString()),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            child: Text(6.toString()),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            child: Text(7.toString()),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            child: Text(8.toString()),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            child: Text(9.toString()),
                            value: 9,
                          ),

                        ],
                        onChanged: (int? newValue){
                          createScoped.dropdownValue = newValue!;
                          createScoped.apiNewValue();
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                          child: const Text('OK', style: TextStyle(color: Colors.white),),
                          onPressed: () {
                            createScoped.apiPostCreate(context);
                          }
                      ),
                    ),
                  ],
                ),
                createScoped.isLoading ?
                const Center(
                    child: CircularProgressIndicator()) :
                const SizedBox.shrink(),
              ],
            );
          }),
        ),
    );
  }
}
