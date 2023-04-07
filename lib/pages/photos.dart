import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_state_model.dart';
import 'custom_elements.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      fillColor: Colors.grey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Search',
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Counter(
                  number: Provider.of<PostModel>(context)
                      .selectedId
                      .length
                      .toString(),
                  isVisible:
                      Provider.of<PostModel>(context).selectedId.isNotEmpty,
                ),
              ],
            ),
          ),
          Wrap(
            children: List<Widget>.generate(
              50,
              (index) => SizedBox(
                height: MediaQuery.of(context).size.width / 3,
                width: MediaQuery.of(context).size.width / 3,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Consumer<PostModel>(
                    builder: (context, value, child) {
                      return FutureBuilder(
                        future: value.postsContent,
                        builder: (context, snapshot) => snapshot.hasData
                            ? InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Material(
                                        child: SafeArea(
                                          child: PostWidget(
                                            postData: snapshot.data?[
                                                index % snapshot.data!.length],
                                            useHero: true,
                                            photoIndex: index,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  value.selectedId.contains(index)
                                      ? value.removeSelection(index)
                                      : value.addSelection(index);
                                },
                                child: SelectivePhoto(
                                  photoData: snapshot
                                      .data?[index % snapshot.data!.length]
                                      .imageData,
                                  index: index,
                                  isSelected: value.selectedId.contains(index),
                                ),
                              )
                            : const Text('Image loading'),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
