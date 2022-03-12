import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/post_model.dart';
import '../pages/home_page.dart';
import '../services/http_service.dart';

class HomeScoped extends Model{
  bool isLoading = false;
  List<Post> items = [];
  var titleController = TextEditingController();
  var bodyController = TextEditingController();
  int dropdownValue = 1;

  var titleUpdateController = TextEditingController();
  var bodyUpdateController = TextEditingController();

  Future apiPostList() async{
    isLoading = true;
    notifyListeners();
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
      items = Network.parsePostList(response);
      notifyListeners();
    }else{
      items = [];
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }
  Future<String?> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    var response = await Network.DEL(Network.API_DELETE + post.id.toString(),
        Network.paramsEmpty());
    isLoading = false;
    notifyListeners();
    if(response != null){
      print("POST:"
          "TITLE: ${post.title} \n"
          "BODY: ${post.body} \n"
          "ID: ${post.id} \n"
          "*** "
          "IS SUCCESSFULLY DELETED!");
    }
    return response;
  }
  apiPostCreate(BuildContext context){
    isLoading = false;
    var title = titleController.text.trim().toString();
    var body = bodyController.text.trim().toString();
    var id = dropdownValue;
    notifyListeners();
    isLoading = true;
    Post post = Post(title: title, body: body, userId: id, id: id);
    var response = Network.POST(Network.API_CREATE, Network.paramsCreate(post));
    if(response != null){
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      print("$title $body $id");
    }
    isLoading = false;
  }
  apiPostUpdate(BuildContext context){
    isLoading = true;
    Post post = Post(title: titleUpdateController.text, body: bodyUpdateController.text, id: Random().nextInt(10), userId: Random().nextInt(10));
    var response = Network.PUT(Network.API_UPDATE, Network.paramsUpdate(post));
    isLoading = false;
    if(response != null){
      Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      print("Post ID:${post.body} is Updated");
    }
  }
  apiChangeInput(){
    notifyListeners();
  }
  apiNewValue(){
    dropdownValue = dropdownValue;
    notifyListeners();
  }
}