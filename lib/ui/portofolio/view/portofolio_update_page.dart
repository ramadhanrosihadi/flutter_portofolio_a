import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/VTheme.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/ImageUtil.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/util/VTime.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/cached_image.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_text.dart';
import 'package:flutter_starter_b/ui/portofolio/model/Portofolio.dart';

class PortofolioUpdatePage extends StatefulWidget {
  PortofolioUpdatePage({Key key, this.documentSnapshot}) : super(key: key);

  @override
  _PortofolioUpdatePageState createState() => _PortofolioUpdatePageState();

  final DocumentSnapshot documentSnapshot;
}

class _PortofolioUpdatePageState extends State<PortofolioUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController startAtController = TextEditingController();
  final TextEditingController endAtController = TextEditingController();
  final TextEditingController clientNameController = TextEditingController();
  final TextEditingController stackController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  List<File> screenshots_file = [];
  List<String> screenshots_url = [];
  List<String> current_screenshots_url = [];
  final double screenshot_height = 100;
  bool isLoading = false;
  Portofolio portofolio = Portofolio();
  List<String> options = ["delete"];

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    portofolio = Portofolio().fromDoc(widget.documentSnapshot);
    titleController.text = portofolio.title;
    descriptionController.text = portofolio.description;
    yearController.text = portofolio.year.toString();
    startAtController.text = portofolio.start_at;
    endAtController.text = Fun.replaceEmpty(portofolio.end_at);
    clientNameController.text = portofolio.client_name;
    stackController.text = portofolio.stacks_string;
    typeController.text = portofolio.type;
    current_screenshots_url = portofolio.screenshot_urls;
  }

  Future uploadFile() async {
    int index = 0;
    screenshots_url.clear();
    for (File file in screenshots_file) {
      String fileName = "${titleController.text.toLowerCase().replaceAll(" ", "")}_${index.toString()}_${VTime.currentTimeStamp()}";
      StorageReference storageReference = FirebaseStorage.instance.ref().child('portofolio/$fileName');
      File compressedFile = await ImageUtil.compressImage(file);
      StorageUploadTask uploadTask = storageReference.putFile(compressedFile);
      Fun.log.wtf("uploadFile index: $index | fileName: $fileName");
      await uploadTask.onComplete;
      String fileURL = await storageReference.getDownloadURL();
      screenshots_url.add(fileURL);
      Fun.log.wtf("uploadFile fileURL: $fileURL");
      index += 1;
    }
  }

  Future update() async {
    portofolio = Portofolio(
      title: titleController.text,
      description: descriptionController.text,
      year: int.parse(yearController.text),
      start_at: startAtController.text,
      end_at: endAtController.text,
      client_name: clientNameController.text,
      stacks_string: stackController.text,
      type: typeController.text,
      screenshot_urls: current_screenshots_url..addAll(screenshots_url),
    );
    widget.documentSnapshot.reference.update(portofolio.toMap());
  }

  Future delete() async {
    bool isOkPressed = await Fun.createDialog(context, title: "Delete Confirmation", message: "Are you sure you want to permanently delete this portofolio?");
    if (isOkPressed) {
      widget.documentSnapshot.reference.delete();
      await Fun.createDialog(context, message: "Portofolio successfully deleted");
      Nav.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Edit",
            style: TextStyle(color: Colors.grey[800], fontSize: 17),
          ),
          iconTheme: IconThemeData(
            color: Colors.grey[800],
            size: 20,
          ),
          brightness: Brightness.light,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) async {
                delete();
              },
              itemBuilder: (BuildContext context) {
                return options.map((value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Theme(
          data: VTheme.defaultForm(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('New Screenshot',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: screenshot_height,
                      child: ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == screenshots_file.length) {
                            return InkWell(
                              onTap: () {
                                ImageUtil.createDialogAmbilGambar(
                                  context,
                                  (path) {
                                    if (path != null) {
                                      setState(() {
                                        screenshots_file.add(File(path));
                                      });
                                    }
                                  },
                                );
                              },
                              child: Container(
                                height: screenshot_height,
                                width: screenshot_height,
                                color: Colors.grey[200],
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: VColor.colorPrimary,
                                    size: 50,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: screenshot_height,
                              margin: EdgeInsets.only(right: 10),
                              child: Stack(children: [
                                Image(
                                  fit: BoxFit.fill,
                                  image: FileImage(screenshots_file[index]),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        screenshots_file.removeAt(index);
                                      });
                                    },
                                    child: Icon(Icons.clear, color: Colors.red, size: 20),
                                  ),
                                )
                              ]),
                            );
                          }
                        },
                        itemCount: screenshots_file.length + 1,
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Current Screenshot',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: screenshot_height,
                      child: ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            height: screenshot_height,
                            margin: EdgeInsets.only(right: 10),
                            child: Stack(children: [
                              CachedImage(
                                url: current_screenshots_url[index],
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      current_screenshots_url.removeAt(index);
                                    });
                                  },
                                  child: Icon(Icons.clear, color: Colors.red, size: 20),
                                ),
                              )
                            ]),
                          );
                        },
                        itemCount: current_screenshots_url.length,
                      ),
                    ),
                    SizedBox(height: 20),
                    FormText(
                      controller: titleController,
                      icon: Icons.title,
                      label: "title",
                    ),
                    Divider(height: 20),
                    FormText(
                      controller: descriptionController,
                      icon: Icons.description,
                      label: "description",
                    ),
                    Divider(height: 20),
                    FormText(
                      controller: yearController,
                      icon: Icons.timelapse,
                      label: "year",
                      textInputType: TextInputType.number,
                    ),
                    Divider(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: FormText(
                            controller: startAtController,
                            icon: Icons.date_range,
                            label: "start at",
                          ),
                        ),
                        Expanded(
                          child: FormText(
                            controller: endAtController,
                            icon: Icons.date_range,
                            label: "end at",
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 20),
                    FormText(
                      controller: clientNameController,
                      icon: Icons.person,
                      label: "client name",
                    ),
                    Divider(height: 20),
                    FormText(
                      controller: stackController,
                      icon: Icons.military_tech,
                      label: "stacks",
                    ),
                    Divider(height: 20),
                    FormText(
                      controller: typeController,
                      icon: Icons.category,
                      label: "type",
                    ),
                    Divider(height: 20),
                    SizedBox(height: 50),
                    (() {
                      if (isLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return ButtonPrimary(
                          text: "ADD",
                          onPressed: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            bool isNoError = _formKey.currentState.validate();
                            if (screenshots_file.length + current_screenshots_url.length == 0) {
                              FlushbarHelper.createError(message: "Screenshot must not be empty").show(context);
                            } else {
                              if (isNoError) {
                                setState(() {
                                  isLoading = true;
                                });
                                await uploadFile();
                                await update();
                                setState(() {
                                  isLoading = false;
                                });
                                await Fun.createDialog(context, message: "Portofolio successfully updated");
                                Nav.pop(context);
                              }
                            }
                          },
                        );
                      }
                    }()),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
