import 'package:categoryquizapp_sample/colorconstants.dart';
import 'package:categoryquizapp_sample/dummydb.dart';
import 'package:categoryquizapp_sample/view/quiz_screen/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:masonry_list_view_grid/masonry_list_view_grid.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.BG_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListTile(
                title: Text(
                  "Hi, Jhon",
                  style: TextStyle(color: Colorconstants.WHITE, fontSize: 25),
                ),
                subtitle: Text(
                  "Let's make this day productive",
                  style: TextStyle(color: Colorconstants.WHITE),
                ),
                trailing: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://cdn4.vectorstock.com/i/1000x1000/29/83/cartoon-little-boy-portrait-in-circle-vector-17552983.jpg"),
                ),
              ),
            ),
            Expanded(
              child: MasonryListViewGrid(
                column: 2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: List.generate(
                  Dummydb.category.length,
                  (index) => Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  categoryData: Dummydb.category[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 200,
                            height:
                                (160 + (index % 3 == 0 ? 30 : 0)).toDouble(),
                            decoration: BoxDecoration(
                              color: Colorconstants.CONTAINER_BG,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      Dummydb.category[index]["category"],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colorconstants.WHITE,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      '${Dummydb.category[index]["totalQuestions"]} Questions',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colorconstants.WHITE,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              Dummydb.category[index]["image"],
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
