
import 'package:flutter/material.dart';

class AssingTwo extends StatefulWidget{
  const AssingTwo({super.key});

  @override
  State<AssingTwo> createState()=> _AssingTwo();
}

class _AssingTwo extends State<AssingTwo>{
  List<Map<String, String>> _dataList = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _addData(){
    //print("add data function -1");
    String name = _nameController.text;
    String number = _numberController.text;

    //print("add data function -2: $name");
    if(_nameController.text.isNotEmpty || _numberController.text.isNotEmpty){

      setState(() {

        _dataList.add({"name": name, "number": number});
        _nameController.clear();
        _numberController.clear();
      });
      print(_dataList);
    }
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this item?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Icon(Icons.no_backpack, color: Colors.blue),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _dataList.removeAt(index);
                });
                Navigator.of(context).pop(); // Close dialog
              },
              //child: Text("Delete", style: TextStyle(color: Colors.red)),
              child: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Contact List", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
                key:_formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText:'Enter Name',
                        border: OutlineInputBorder(),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Name not allow";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Number',
                        border: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Empty Number not allow";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              print("add data-1");
                              _addData();
                            }

                          },
                          child: Text('Add',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)
                      ),
                    ),

                    SizedBox(height: 20,),



                  ],
                )

            ),



            Expanded(

                child:_dataList.isEmpty
                    ? Center(child: Text("No data added yet!"))
                    :ListView.builder(
                    itemCount: _dataList.length,
                    itemBuilder: (context, index){


                      return Card(
                        child: ListTile(

                          leading:Icon(Icons.person, color: Colors.blue),
                          title: Text(_dataList[index]['name']??""),
                          subtitle: Text(_dataList[index]['number']??""),
                          trailing:Icon(Icons.call, color: Colors.blue),
                          onLongPress: () => _confirmDelete(index),
                        ),
                      );



                    }
                )
            )

          ],
        ) ,
      ),
    );
  }
}
