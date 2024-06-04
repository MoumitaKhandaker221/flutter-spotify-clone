import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BanglaMusic extends StatefulWidget {
  const BanglaMusic({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BanglaMusicState();
}

class _BanglaMusicState extends State<BanglaMusic> {
  late List<Map<String, dynamic>> albumList;

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  Future<void> fetchAlbums() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('banglaSong').get();
      setState(() {
        albumList = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (error) {
      print('Error fetching albums: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: albumList.length,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          final album = albumList[index];

          return Column(
            children: [
              Container(
                height: 145,
                width: 145,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: album['image'] != null ? Image.network(
                  album['image'],
                  fit: BoxFit.cover,
                ) : Image.network(
                  'https://www.theaudiodb.com/images/media/track/thumb/syswqy1340354244.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                album["songName"] ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
