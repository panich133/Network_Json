import 'package:flutter/material.dart';
import 'package:my_authen_jsonfeed/model/Youtubes.dart';
import 'package:my_authen_jsonfeed/services/AuthService.dart';
import 'package:my_authen_jsonfeed/services/Network.dart';

class Home extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Home> {
  AuthService auService = AuthService();

  String type = 'superheroAAAAAAA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_outlined),
            onPressed: () {
              auService.logout();

              Navigator.pushNamedAndRemoveUntil(
                  context, '/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Youtube>>(
          future: Network.fetchYoutube(type: type),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: 3,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: _listSection(youtubes: snapshot.data),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _listSection({List<Youtube> youtubes}) => ListView.builder(
      itemCount: youtubes.length,
      itemBuilder: (context, index) {
        if (index == 0) {
          return _headerImageSelection();
        }

        var item = youtubes[index];

        return Card(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              children: <Widget>[
                _heraderSectionCard(youtube: item),
                _bodySectionCard(youtube: item),
                _footerSectionCard(youtube: item),
              ],
            ));
      });

  Widget _headerImageSelection() => Padding(
        padding: EdgeInsets.fromLTRB(10, 1, 10, 30),
        child: Image.asset(
          'assets/header_home.png',
          alignment: Alignment.topCenter,
          height: 400,
        ),
      );

  Widget _heraderSectionCard({Youtube youtube}) => ListTile(
        leading: Container(
          padding: EdgeInsets.only(top: 5),
          child: ClipOval(
            child: Image.network(
              youtube.avatarImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          youtube.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
        subtitle: Text(
          youtube.subtitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );

  Widget _bodySectionCard({Youtube youtube}) => Image.network(
        youtube.youtubeImage,
        fit: BoxFit.cover,
      );

  Widget _footerSectionCard({Youtube youtube}) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _customFlatBotton(icon: Icons.comment_outlined, label: 'Comment..'),
          _customFlatBotton(icon: Icons.linked_camera, label: 'Camera'),
          _customFlatBotton(icon: Icons.thumb_up_alt, label: 'Like'),
          SizedBox(
            height: 50,
          ),
        ],
      );

  Widget _customFlatBotton({IconData icon, String label}) => FlatButton(
        onPressed: () {},
        child: Row(
          children: <Widget>[
            Icon(icon),
            SizedBox(
              width: 5,
            ),
            Text(label),
          ],
        ),
      );
}
