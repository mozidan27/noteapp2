import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteTile extends StatelessWidget {
  const NoteTile(
      {super.key,
      required this.text,
      this.onEditPressed,
      this.onDeletePressed});
  final String text;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        // extentratio used to resize the slidable
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onDeletePressed,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      startActionPane: ActionPane(
        // extentratio used to resize the slidable
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: onEditPressed,
            icon: Icons.edit,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primary),
        child: Text(text),
      ),
    );
  }
}
