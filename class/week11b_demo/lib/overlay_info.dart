import 'package:flame_overlays/game.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfoOverlay extends StatelessWidget {
  final OverlayTutorial game;
  const InfoOverlay({super.key, required this.game});

  final String infoText = """
<!DOCTYPE html>
<html>
<head>
<style>
body {
  font-family: Arial, sans-serif;
  font-size: 45px;
  color: black;
  padding: 20px;
}
</style>
</head>
<body>
<h1>Overlay Info</h1>
<p>
<b>Lorem ipsum</b> dolor sit amet, consectetur adipiscing elit. Sed ornare tortor quis elementum 
congue. Praesent venenatis ligula lacus, vestibulum varius erat tempor eu. Integer est leo, 
vehicula et urna id, ornare consectetur augue. Phasellus molestie eros sed vehicula ultricies. 
Nunc euismod urna nec sollicitudin volutpat. Donec vitae orci et mauris cursus viverra 
posuere eget sem. 
</p>
<p>
Integer pharetra turpis eu placerat pellentesque. Maecenas ac quam id lorem posuere ultrices. 
Ut aliquet in urna molestie porta. Praesent arcu ipsum, imperdiet ac arcu eu, elementum vehicula 
felis. Mauris hendrerit urna ex, in egestas felis pharetra sit amet. In quis consectetur 
tortor, eu volutpat ipsum. Mauris luctus gravida lorem, quis tempus tellus lobortis nec. 
Integer ornare sapien eget nisl fringilla sodales. Phasellus a massa id est rutrum pretium. 
Nullam tristique, tortor quis tincidunt euismod, odio arcu pulvinar ligula, 
sit amet dictum nunc felis sed orci.
</p>
</body>
</html>
""";

  @override
  Widget build(BuildContext context) {
    WebViewController webView = WebViewController();
    webView.loadHtmlString(infoText);

    return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 350,
            height: 400,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 244, 43, 164),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: WebViewWidget(controller: webView),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    game.overlays.remove("info");
                    game.paused = false;
                  },
                  child: Text("Close"),
                ),
              ],
            ),
          ),
        ));
  }
}
