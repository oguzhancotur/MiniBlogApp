import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  String title = '';
  String content = '';
  String author = '';

  // Resim seçim işlemi.
  openImagePicker(ImageSource source) async {
    XFile? selectedFile = await _picker.pickImage(source: source);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  submitForm() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    var request = http.MultipartRequest("POST", url);

    if (selectedImage != null) {
      request.files
          .add(await http.MultipartFile.fromPath("File", selectedImage!.path));
    }

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    final response = await request.send();

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 180, 24),
        title: Text(
          "Blog Ekle",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (selectedImage != null)
                Image.file(
                  File(selectedImage!.path),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      openImagePicker(ImageSource.gallery);
                    },
                    child: Text(
                      "Galeriden Seç",
                      style: TextStyle(color: Color.fromARGB(255, 0, 180, 24)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      openImagePicker(ImageSource.camera);
                    },
                    child: Text("Kameradan Seç",
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 180, 24))),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Blog Başlığı"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen Başlık Giriniz";
                  }
                  return null;
                },
                onSaved: (newValue) => title = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Blog İçeriği"),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen Blog İçeriği Giriniz";
                  }
                  return null;
                },
                onSaved: (newValue) => content = newValue!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Ad Soyad"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen Ad Soyad Giriniz";
                  }
                  return null;
                },
                onSaved: (newValue) => author = newValue!,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (selectedImage == null) {
                      return;
                    }

                    _formKey.currentState!.save();
                    submitForm();
                  }
                },
                child: Text("Gönder"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
