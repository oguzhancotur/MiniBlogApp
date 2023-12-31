import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblogapp/blocs/article_bloc/article_bloc.dart';
import 'package:miniblogapp/blocs/article_bloc/article_event.dart';

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
                    context.read<ArticleBloc>().add(PostArticle(
                        title: title,
                        content: content,
                        author: author,
                        image: selectedImage!.path));
                    Navigator.pop(context, true);
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
