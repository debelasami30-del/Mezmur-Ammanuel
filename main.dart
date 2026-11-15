import 'package:flutter/material.dart';

void main() {
  runApp(const MezmurEmmanuelApp());
}

class MezmurEmmanuelApp extends StatelessWidget {
  const MezmurEmmanuelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'መዝሙር አማኑኤል',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List> allMezmurs = [
    {'title': 'መዝሙረ ዳዊት ምዕራፍ 23', 'category': 'መዝሙረ ዳዊት', 'artist': 'ንባብ'},
    {'title': 'አማኑኤል መጠጊያዬ ነው', 'category': 'ፕሮቴስታንት መዝሙር', 'artist': 'ዘማሪ ቴዎድሮስ ዮሴፍ'},
    {'title': 'እግዚአብሔር እረኛዬ ነው', 'category': 'ኦርቶዶክስ መዝሙር', 'artist': 'ሊቀ መዘምራን በእደማርያም'},
    {'title': 'ልቤ በእግዚአብሔር ደስ ይለዋል', 'category': 'ፕሮቴስታንት መዝሙር', 'artist': 'አልበም ፊት አውራሪ'},
  ];

  List> filteredMezmurs = [];

  @override
  void initState() {
    super.initState();
    filteredMezmurs = allMezmurs;
  }

  void _runSearch(String enteredKeyword) {
    List> results = [];
    if (enteredKeyword.isEmpty) {
      results = allMezmurs;
    } else {
      results = allMezmurs
          .where((mezmur) =>
              mezmur['title']!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              mezmur['category']!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              mezmur['artist']!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredMezmurs = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('መዝሙር አማኑኤል'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runSearch(value),
              decoration: InputDecoration(
                labelText: 'መዝሙር፣ ዘማሪ ወይም መዝሙረ ዳዊት ይፈልጉ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredMezmurs.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredMezmurs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Icon(Icons.music_note, color: Colors.white),
                            ),
                            title: Text(
                              filteredMezmurs[index]['title']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Text(
                              '${filteredMezmurs[index]['category']} • ${filteredMezmurs[index]['artist']}',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            trailing: const Icon(Icons.play_arrow, color: Colors.deepPurple),
                            onTap: () {},
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'ምንም መዝሙር አልተገኘም!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
