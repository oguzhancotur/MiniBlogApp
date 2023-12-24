import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:miniblogapp/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:miniblogapp/screens/add_blog.dart';
import 'package:miniblogapp/screens/blog_details.dart';
import 'package:miniblogapp/widgets/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();

    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 180, 24),
        title: const Text(
          "Blog Sayfası",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool? result = await Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddBlog()),
              );

              if (result == true) {
                fetchBlogs();
              }
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: blogs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                fetchBlogs();
              },
              child: ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (blogs[index].id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BlogDetails(blogId: blogs[index].id!),
                        ),
                      );
                    }
                  },
                  child: BlogItem(blog: blogs[index]),
                ),
                itemCount: blogs.length,
              ),
            ),
    );
  }
}
