import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_b/common/constant/VColor.dart';
import 'package:flutter_starter_b/common/constant/VString.dart';
import 'package:flutter_starter_b/common/util/Fun.dart';
import 'package:flutter_starter_b/common/util/ImageUtil.dart';
import 'package:flutter_starter_b/common/util/Nav.dart';
import 'package:flutter_starter_b/common/util/VTime.dart';
import 'package:flutter_starter_b/common/widget/button_primary.dart';
import 'package:flutter_starter_b/common/widget/scaffold_default.dart';
import 'package:flutter_starter_b/ui/auth/signin/widgets/form_text.dart';
import 'package:flutter_starter_b/ui/portofolio/model/Portofolio.dart';

class PortofolioCreatePage extends StatefulWidget {
  PortofolioCreatePage({Key key}) : super(key: key);

  @override
  _PortofolioCreatePageState createState() => _PortofolioCreatePageState();
}

class _PortofolioCreatePageState extends State<PortofolioCreatePage> {
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
  final double screenshot_height = 100;
  bool isLoading = false;

  Future addPortofolio() async {
    Fun.log.v("addPortofolio screenshot_urls: " + screenshots_url.toString());
    Portofolio(
      title: titleController.text,
      description: descriptionController.text,
      year: int.parse(yearController.text),
      start_at: startAtController.text,
      end_at: endAtController.text,
      client_name: clientNameController.text,
      stacks_string: stackController.text,
      type: typeController.text,
      screenshot_urls: screenshots_url,
    ).insertToFireStore();
    await Fun.createDialog(context, message: "New portofolio successfully added");
    Nav.pop(context);
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

  void setDummy() {
    descriptionController.text = VString.lorem_ipsum;
    yearController.text = "2020";
    titleController.text = "Title";
    startAtController.text = "2020-03-12";
    clientNameController.text = "Client Name Corp.";
    stackController.text = "flutter, laravel";
    typeController.text = "android, ios, web";
  }

  @override
  void initState() {
    super.initState();
    setDummy();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(
      textTitle: " Add Portofolio",
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Screenshot',
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
                        if (screenshots_file.length == 0) {
                          FlushbarHelper.createError(message: "Screenshot must not be empty").show(context);
                        } else {
                          if (isNoError) {
                            setState(() {
                              isLoading = true;
                            });
                            await uploadFile();
                            setState(() {
                              isLoading = false;
                            });
                            addPortofolio();
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
    );
  }
}
