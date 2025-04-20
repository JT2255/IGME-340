import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:like_button/like_button.dart';
import 'main.dart';

class DealsBody extends StatelessWidget {
  const DealsBody({
    super.key,
    required this.dealsList,
  });

  final List dealsList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dealsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {                
                    showInfo(context, index);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: canvasColor, width: 2.5),
                        borderRadius: BorderRadius.circular(20.0) 
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(17.0),
                            child: SizedBox(
                              height: 150,
                              child: Image.network(
                                "${dealsList[index]["image"]}",
                                fit: BoxFit.fill,
                              ),
                            )
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "${dealsList[index]["title"]}".length > 30 ? '${dealsList[index]["title"].substring(0, 27)}...' : '${dealsList[index]["title"]}',
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "\$${dealsList[index]["salePrice"]}  ",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  "${dealsList[index]["normalPrice"]}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                );
              },
            ),
          ),
        ],         
      ),
    );
  }

  Future<dynamic> showInfo(BuildContext context, int index) {
    return showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text("${dealsList[index]["title"]}"),
              Spacer(),
              LikeButton(
                isLiked: dealsList[index]["isLiked"],
                onTap: (isLiked) async {
                  // add to favorites list
                  if (!isLiked) {
                    favoritesList.add(dealsList[index]);
                    dealsList[index]["isLiked"] = true;
                  } else {
                    favoritesList.remove(dealsList[index]);
                    dealsList[index]["isLiked"] = false;
                  }

                  return !isLiked;
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(dealsList[index]["image"]),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text("On Sale For: \$${dealsList[index]["salePrice"]}", style: TextStyle(fontSize: 15),),
                ),
                Text("Lowest Seen Price: \$${dealsList[index]["cheapestPrice"]}", style: TextStyle(fontSize: 15),),
                Text("\n${dealsList[index]["rating"]}% of ${dealsList[index]["ratingCount"]} user reviews are positive"),
                Text("Metacritic Score: ${dealsList[index]["metacriticScore"]}"),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                FilledButton(
                  onPressed: () {
                    // mailing list stuff
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  child: Text("Email"),
                ),
              ],
            ),
            Row(
              children: [                               
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilledButton(
                    onPressed: () {
                      // open metacritic
                      launchUrlString("https://www.metacritic.com${dealsList[index]["metacriticLink"]}", mode: LaunchMode.externalApplication);
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    ),
                    child: Text("Metacritic"),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    // open steam page or app if installed on phone
                    launchUrlString("https://store.steampowered.com/app/${dealsList[index]["steamID"]}", mode: LaunchMode.externalApplication);
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  child: Text("Steam"),
                ),
              ],
            ),                          
          ],
        );
      }
    );
  }
}