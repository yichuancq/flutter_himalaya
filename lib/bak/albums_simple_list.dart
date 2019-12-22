import 'package:flutter/material.dart';

class AlbumsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AlbumsListState();
  }
}

class _AlbumsListState extends State<AlbumsList> {
  ///
  Widget _albumsList() {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Image.network(
                "http://fdfs.xmcdn.com/group49/M08/65/99/wKgKmFvATgqSrkOFAABmXBiu0v8811_web_large.jpg"),
            title: Text("Albums"),
            subtitle: Text("albums subTitle"),
            trailing: IconButton(icon: Icon(Icons.chevron_right)),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: Colors.red,
          ),
          ListTile(
            //
            leading: Image.network(
                "http://fdfs.xmcdn.com/group49/M08/65/99/wKgKmFvATgqSrkOFAABmXBiu0v8811_web_large.jpg"),
            title: Text("Albums"),
            subtitle: Text("albums subTitle"),
            trailing: IconButton(icon: Icon(Icons.chevron_right)),
            onTap: () {},
          ),
          Divider(
            height: 1,
            color: Colors.red,
          ),
          ListTile(
            leading: Image.network(
                "http://fdfs.xmcdn.com/group49/M08/65/99/wKgKmFvATgqSrkOFAABmXBiu0v8811_web_large.jpg"),
            title: Text("Albums"),
            subtitle: Text("albums subTitle"),
            trailing: IconButton(icon: Icon(Icons.chevron_right)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  ///
  Widget _albumsBuilder() {
    return Container(
      child: ListView(
        children: <Widget>[
          _albumsList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Albums"),
      ),
      body: Container(
        child: _albumsBuilder(),
      ),
    );
  }
}
