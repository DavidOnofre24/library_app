import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text('Library app', style: titleStyle),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      // showSearch(
                      //         context: context,
                      //         delegate: SearchSpotifyDelegate())
                      //     .then((value) {
                      //   if (value == null) return;
                      //   final values = value.split('-');
                      //   goDetail(context, values[0], values[1]);
                      // });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }

  void goDetail(BuildContext context, String id, String type) {
    switch (type) {
      case 'track':
        context.go('/home/0/track-detail/$id');
        break;
      case 'artist':
        context.go('/home/0/artist-detail/$id');
        break;
      case 'album':
        context.go('/home/0/album-detail/$id');
        break;
      default:
        break;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
