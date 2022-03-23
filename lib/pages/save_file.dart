import 'package:flutter/material.dart';
import 'package:richtext_editor/model/SaveFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class SaveFilePage extends StatefulWidget  {
  @override
  _SaveFilePageState createState() => _SaveFilePageState();
}

class _SaveFilePageState extends State<SaveFilePage> {
  List<SaveFile> saveFileList = [];

  getFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? musicsString = prefs.getString('Journals');
    final List<SaveFile> tempSaveFileList = SaveFile.decode(musicsString!);
    setState(() {
      saveFileList = tempSaveFileList;
    });
    print(saveFileList.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: false,
        title: const Text("Save Journals"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: saveFileList.isEmpty
                    ? const Center(
                        child: Text("No Data Found!"),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Text(
                                saveFileList[index].title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Expanded(child: SizedBox()),
                              const SizedBox(width: 15,),
                              GestureDetector(
                                onTap:(){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete"),
                                        content: const Text("Are you sure you want to delete this??"),
                                        actions: [
                                          TextButton(
                                            child: const Text("CANCEL"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () async {
                                               setState(() {
                                                 saveFileList.removeAt(index);
                                               });
                                               final prefs = await SharedPreferences.getInstance();
                                               final String encodedData = SaveFile.encode(saveFileList);
                                               await prefs.setString('Journals', encodedData);
                                               getFromStorage();
                                               Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 15,),
                              GestureDetector(
                                onTap:(){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(position: index,),
                                    ),
                                  ).then((value) {
                                    getFromStorage();
                                  });
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                        itemCount: saveFileList.length)),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(position: -1,),
                      ),
                    ).then((value) {
                      getFromStorage();
                    });
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.red,
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Add Journals",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
