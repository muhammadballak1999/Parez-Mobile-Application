import 'package:flutter/material.dart';
import 'package:flutter_auth/models/api_services.dart';
import 'package:flutter_auth/bottombar/details_screen.dart';
import 'package:flutter_auth/generated/l10n.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key key}) : super(key: key);

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  Map<String, dynamic> response;
  List<dynamic> blogs;
  bool loading = true;
  APIService apiService = APIService();

  getData() async {
    response = await APIService.get('blogs');
    setState(() {
      blogs = response["data"];
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          title: Text(S.of(context).news),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Colors.purple,
                  Colors.deepPurple,
                ])),
          ),
        ),
        body: loading
            ? Center(
                child: Container(
                    child: CircularProgressIndicator(
                color: Colors.purple,
              )))
            : blogs.length != 0
                ? ListView.builder(
                    itemCount: blogs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: InkWell(
                          // onTap: () {
                          //   Navigator.of(context).push(
                          //     PageRouteBuilder(
                          //       pageBuilder: (context, anim, child) {
                          //         return FadeTransition(
                          //           child: Setting(),
                          //           opacity: anim,
                          //         );
                          //       },
                          //     ),
                          //   );
                          // },
                          child: Container(
                            child: SizedBox(
                              height: 400.0,
                              child: Card(
                                elevation: 2.0,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              blogs[index]["title"],
                                              blogs[index]["attachment"]["url"],
                                              blogs[index]["content"]),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Center(
                                            child: Image.network(
                                                blogs[index]["attachment"]
                                                    ["url"],
                                                width: 300,
                                                height: 300),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Text(
                                          blogs[index]["title"],
                                          style: TextStyle(
                                            color: Color(0xFF1a1a1a),
                                            fontSize: 24.0,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          blogs[index]["content"],
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: Container(child: Text(S.of(context).noBlogs))));
  }
}
