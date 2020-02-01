import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:todo/models/category.dart';
import 'package:todo/services/category_service.dart';
class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}
class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryName = TextEditingController();
  var _categoryDescription = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }


  getAllCategories() async{
    var categories = await _categoryService.getCategories();
    categories.foreach((category){
      print(category['name']);
    });


  }


  _showFormInDialog(BuildContext context){
    return showDialog(context: context,barrierDismissible: true, builder: (paran){
      return AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: (){

            },
            child: Text('cancel'),
          ),

          FlatButton(
            onPressed: () async {
             _category.name = _categoryName.text;
             _category.description= _categoryDescription.text;
             var result = await _categoryService.saveCategory(_category);
             print(result);
            },
            child: Text('Save'),
          )

        ],


     title: Text('Catergory form'),content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
              TextField(
                controller: _categoryName ,
              decoration: InputDecoration(
                labelText: 'Category Name',
                hintText: 'Write a Category Name'
              ),
            ),

            TextField(
              controller: _categoryDescription,
              decoration: InputDecoration(
                  labelText: 'Category Description',
                  hintText: 'Write a Category Description'
              ),
            ),
          ],
        ),
      ),);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: RaisedButton(
          elevation: 0.0,
          color:Colors.red,
          child: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomeScreen()));

          },
        ),
        title: Text("El ToDo"),
      ),
      body: Center(child: Text("Welcome to categories screen!"),),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _showFormInDialog(context);
      }, child: Icon(Icons.add),),
    );
  }
}