import 'main.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// require a list to passed in when calling widget
/// this class returns a body that contains all of the formatting
/// when passing in data from the api
class DealsBody extends StatelessWidget {
  const DealsBody({
    super.key,
    required this.dealsList,
  });

  // list of deals passed in (either normal deals or favorites)
  final List dealsList;

  // build widget body
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            // list view builder return tiles for every game in list
            child: ListView.builder(
              itemCount: dealsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  // when clicking on a game, show alert dialog with more info
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
                          // clip images to be round
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
                                // cut off name if too long so no overflow errors occur
                                child: Text(
                                  "${dealsList[index]["title"]}".length > 30 ? '${dealsList[index]["title"].substring(0, 27)}..' : '${dealsList[index]["title"]}',
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              ),
                              Spacer(),
                              // show sale price as green
                              Text(
                                "\$${dealsList[index]["salePrice"]}  ",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                ),
                              ),
                              // show normal price as red and crossed out
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

  /// Function that returns an alert dialog containing game info
  Future<dynamic> showInfo(BuildContext context, int index) {
    return showDialog(
      context: (context),
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              // cut off name if too long so no overflow errors occur
              Text("${dealsList[index]["title"]}".length > 17 ? '${dealsList[index]["title"].substring(0, 14)}..' : '${dealsList[index]["title"]}'),
              Spacer(),
              // like button that allows users to add to their favorites list
              LikeButton(
                isLiked: dealsList[index]["isLiked"],
                onTap: (isLiked) async {
                  // add to favorites list
                  if (!favoritesList.contains(dealsList[index])) {
                    favoritesList.add(dealsList[index]);
                    dealsList[index]["isLiked"] = true;
                    isLiked = true;
                    saveData();
                    return isLiked;
                  } else { // remove from favorites list
                    isLiked = false;
                    dealsList[index]["isLiked"] = false;
                    favoritesList.remove(dealsList[index]);     
                    saveData();            
                    return isLiked;
                  }
                },
              ),
            ],
          ),
          // contains pricing history as well as ratings and reviews
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
                Text("Released On: ${dealsList[index]["releaseDate"]}"),
              ],
            ),
          ),
          actions: [
            Row(
              children: [                               
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilledButton(
                    onPressed: () {
                      // open metacritic website in-app
                      launchUrlString("https://www.metacritic.com${dealsList[index]["metacriticLink"]}", mode: LaunchMode.inAppBrowserView);
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
                    ),
                    child: Text("Metacritic"),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    // open steam page, kept as external for purposes of opening steam app if it is installed on phone
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