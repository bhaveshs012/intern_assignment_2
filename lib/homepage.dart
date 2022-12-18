import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intern_assignment_2/controller/apiController.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  ApiController apiController = Get.put(ApiController());
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _controller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black54,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10.0,
                      ),
                    ),
                  ),
                  hintText: 'Search for Movies',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      //* search function
                      if (_controller.text.isEmpty) {
                        return;
                      }
                      apiController.fetchDate(
                        _controller.text,
                      );
                      FocusScope.of(context).unfocus();
                      _controller.clear();
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Obx(
                  () => apiController.movie == null
                      ? Center(
                          child: Text('Search for moive'),
                        )
                      : apiController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount:
                                  apiController.movie!.search!.length ?? 0,
                              itemBuilder: (context, index) {
                                return MovieCard(
                                  title: apiController
                                          .movie!.search![index].title ??
                                      '',
                                  genre: apiController
                                          .movie!.search![index].type ??
                                      '',
                                  rating: apiController
                                          .movie!.search![index].imdbID ??
                                      '',
                                  image: apiController
                                          .movie!.search![index].poster ??
                                      '',
                                );
                              }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String genre;
  final String rating;
  final String image;
  const MovieCard({
    Key? key,
    required this.title,
    required this.genre,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 25,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 220,
      child: Row(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    genre.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.lightGreen,
                    ),
                    child: Text(
                      rating.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
