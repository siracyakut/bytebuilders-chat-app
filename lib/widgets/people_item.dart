import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/people.dart';

class PeopleItem extends StatelessWidget {
  final People people;
  final int index;
  final Function func;

  const PeopleItem({
    super.key,
    required this.people,
    required this.index,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(
        "/message",
        arguments: [
          people,
          index,
          func,
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(people.avatarUrl),
              radius: 28,
            ),
            const Gap(20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    people.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(1),
                  Row(
                    children: [
                      if (people.unreadCount == -1) renderSentIcon(),
                      Expanded(
                        child: Text(
                          people.lastMessage,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text(people.dateTime),
                  if (people.unreadCount > 0) renderUnreadMessages()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSentIcon() {
    return const Padding(
      padding: EdgeInsets.only(right: 3.0),
      child: Icon(Icons.reply, size: 18),
    );
  }

  Widget renderUnreadMessages() {
    return Container(
      width: 25,
      height: 25,
      margin: const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(112, 62, 254, 1),
        borderRadius: BorderRadius.circular(12.5),
      ),
      child: Center(
        child: Text(
          people.unreadCount.toString(),
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
