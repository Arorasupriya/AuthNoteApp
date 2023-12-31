import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_note_fb/constants/app_colors.dart';
import 'package:login_note_fb/constants/custom_widget.dart';
import 'package:login_note_fb/model/data_model.dart';
import 'package:login_note_fb/screens/note_detail.dart';

class Dashboard extends StatefulWidget {
  late String id;

  Dashboard({super.key, required this.id});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late FirebaseFirestore db;

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              ColorConstant.gradiantDarkColor,
              ColorConstant.gradiantLightColor
            ])),
        child: StreamBuilder(
            stream: db
                .collection("users")
                .doc(widget.id)
                .collection("notes")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      hSpacer(),
                      const Text(
                        "Recent",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorConstant.fontBlackColor),
                      ),
                      hSpacer(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, top: 5, bottom: 5),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1),
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var currentData = DataModel.fromJson(
                                    snapshot.data!.docs[index].data());
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 10),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NoteDetail(
                                                    getId: snapshot
                                                        .data!.docs[index].id,
                                                    index: index,
                                                    getUserId: widget.id,
                                                  )));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(110),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(children: [
                                          Text(
                                            currentData.title.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            softWrap: true,
                                            maxLines: 6,
                                            textAlign: TextAlign.left,
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Text(
                                                currentData.dateTime.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      const Text(
                        "All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: ColorConstant.fontBlackColor),
                      ),
                      hSpacer(),
                      Expanded(
                          flex: 2,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var currentData = DataModel.fromJson(
                                    snapshot.data!.docs[index].data());
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, bottom: 10),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => NoteDetail(
                                                    getId: snapshot
                                                        .data!.docs[index].id,
                                                    index: index,
                                                    getUserId: widget.id,
                                                  )));
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(110),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Stack(children: [
                                          Text(
                                            currentData.title.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            softWrap: true,
                                            maxLines: 5,
                                            textAlign: TextAlign.left,
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Text(
                                                currentData.dateTime.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          Positioned(
                                              top: 2,
                                              right: 2,
                                              child: InkWell(
                                                  onTap: () {
                                                    var id = snapshot
                                                        .data!.docs[index].id;
                                                    print("id====>$id");
                                                    db
                                                        .collection("users")
                                                        .doc(widget.id)
                                                        .collection("notes")
                                                        .doc(id)
                                                        .delete()
                                                        .then((value) {
                                                      print("Deleted Record");
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ))),
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                );
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.gradiantDarkColor,
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: ColorConstant.gradiantDarkColor,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(21),
                      topLeft: Radius.circular(21))),
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      hSpacer(),
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "Add Note",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            style: const TextStyle(fontSize: 12),
                            controller: titleController,
                            decoration: InputDecoration(
                                hintText: "Enter Title",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(21)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            ColorConstant.gradiantLightColor),
                                    borderRadius: BorderRadius.circular(21)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            ColorConstant.gradiantLightColor),
                                    borderRadius: BorderRadius.circular(21))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          style: const TextStyle(fontSize: 12),
                          controller: descController,
                          maxLines: 8,
                          decoration: InputDecoration(
                              hintText: "Enter Description",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(21)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConstant.gradiantLightColor),
                                  borderRadius: BorderRadius.circular(21)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ColorConstant.gradiantLightColor),
                                  borderRadius: BorderRadius.circular(21))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: ColorConstant.gradiantLightColor),
                          onPressed: () {
                            var title = titleController.text.toString();
                            var desc = descController.text.toString();
                            DateTime nowDT = DateTime.now();
                            String formattedDate =
                                DateFormat('EEE d MMM').format(nowDT);
                            db
                                .collection("users")
                                .doc(widget.id)
                                .collection("notes")
                                .add(DataModel(
                                        title: title,
                                        desc: desc,
                                        dateTime: formattedDate)
                                    .toJson())
                                .then((value) {
                              print(value);
                            });
                            titleController.clear();
                            descController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 12, color: ColorConstant.fontBlackColor),
                          ))
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add,
          size: 30,
          fill: 1.0,
          color: ColorConstant.fontBlackColor,
        ),
      ),
    );
  }
}
