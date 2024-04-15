import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_setting.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteTile({
    super.key, 
    required this.text, 
    required this.onEditPressed, 
    required this.onDeletePressed,
    }
    );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.only( top: 10,left: 25,right: 25,),
      child: ListTile(
        title: Text(text),
        trailing: Builder(
          builder: (context) => IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => showPopover(
            height: 80,
            width: 80,
            backgroundColor: Theme.of(context).colorScheme.background,
            context: context,
            bodyBuilder: (context) => NoteSetting(
              onEditTap: onEditPressed,
              onDeleteTap: onDeletePressed,
             ),
            ),
          ),
        ),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       onPressed: onEditPressed,
        //       icon: const Icon(Icons.edit)),
        //     IconButton(
        //         onPressed: onDeletePressed,
        //         icon: const Icon(Icons.delete)),
        //   ],
        // ),
      ),
    );
  }
}
