import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogDetails extends StatefulWidget {
  const BlogDetails({Key? key, required this.blogId}) : super(key: key);

  final String blogId;

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  late Future<Map<String, dynamic>> _blogDetails;

  @override
  void initState() {
    super.initState();

    _blogDetails = fetchBlogDetails(widget.blogId);
  }

  Future<Map<String, dynamic>> fetchBlogDetails(String id) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 180, 24),
        title: const Text(
          "Detay Sayfası",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: _blogDetails,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text("Veri Alınamadı"));
          } else {
            return buildBlogDetailsUI(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget buildBlogDetailsUI(Map<String, dynamic> blogData) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Card(
        color: const Color.fromARGB(255, 243, 243, 243),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                blogData['thumbnail'] ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Başlık: ${blogData['title']}",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 180, 24)),
                  ),
                  const SizedBox(height: 8),
                  Text("İçerik: ${blogData['content']}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text("Yazar: ${blogData['author']}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 102, 0, 118))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
