import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                  // Add this code
                  preferredSize: Size.fromHeight(275.0), // Add this code
                  child: Column(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/200"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                      child: Row(
                        children: [
                          Text(
                            "kuantum",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.blue,
                                  Colors.red,
                                ],
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                              ),
                            ),
                            child: new FlatButton(
                                child: new Text(
                                  'Katıl',
                                ),
                                onPressed: () {
                                  //   print('Clicked');
                                }),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                              colors: [Color(0xff6DC8F3), Color(0xff73A1F9)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff73A1F9),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 6.0, top: 6.0),
                                child: Text(
                                  "dgfnfıgfndgımdıfmvıdmvomvofoggnunfjnvjdnvjfdnvjfj jf j",
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 6.0, bottom: 6.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "55",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                  // Spacer(),
                                  Text("43",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]) // Add this code
                  ),
              //   backgroundColor: this.color,
              /*  flexibleSpace: FlexibleSpaceBar(
                title: Text("Yopluluk"),
                /*  title: Container(
                /*  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"),
                      fit: BoxFit.cover,
                    ),*/

                height: 300, //MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                    Text("fgfdgdgfdg"),
                  ],
                ),
              )*/
              ),*/
            ),
          ];
        },
        body: Container(child: Builder(builder: (context) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [Text("gfgff"), Text("gfhh")]);
        })),
      ),
    );
  }
}

/*
class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                //  flexibleSpace: FlexibleSpaceBar(
                //  centerTitle: true,
                title: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://picsum.photos/200"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    /* Row(
                      children: [
                        Text(
                          "sfd",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: new LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.red,
                              ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter,
                            ),
                          ),
                          child: new FlatButton(
                              child: new Text(
                                'Katıl',
                              ),
                              onPressed: () {
                                //   print('Clicked');
                              }),
                        )
                      ],
                    ),*/
                    Text("cdvd"),
                    Text("fghgf")
                    /*   Text("Collapsing Toolbar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            )),*/
                  ],
                ),
                /*    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )*/
                //),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Center(
            child: Text("Sample Text"),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
*/
