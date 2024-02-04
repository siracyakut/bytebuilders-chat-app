// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../core/storage.dart';
import '../core/variables.dart';
import '../widgets/message_item.dart';
import '../models/people.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var messageController = TextEditingController();

  // Kullanicinin bu sayfaya erisimi yoksa welcomeScreen'e gonderiyoruz.
  getUser() async {
    Storage storage = Storage();

    var user = await storage.loadUser();

    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/welcome", (route) => false);
    }
  }

  // Screen'imiz yuklendiginde auth fonksiyonumuzu calistiriyoruz.
  @override
  void initState() {
    super.initState();
    getUser();
  }

  sendMessage(_, index, func) {
    dynamic currentTime = DateFormat('hh:mm a')
        .format(DateTime.now().add(const Duration(hours: 3)));

    setState(() {
      messages[index].add(
        MessageItem(
          message: messageController.text,
          time: currentTime,
          isMe: false,
        ),
      );

      peopleList[index].lastMessage = messageController.text;
      peopleList[index].unreadCount = -1;
      peopleList[index].dateTime = currentTime;
    });
    func();
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final People people = arguments[0];
    final int index = arguments[1];
    final Function func = arguments[2];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.0),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(people.avatarUrl),
                  radius: 25,
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      people.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    getOnlineOrOffline()
                  ],
                ),
              ],
            ),
            const Row(
              children: [
                Icon(Icons.videocam),
                Gap(25),
                Icon(Icons.phone),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 241, 241, 241),
        ),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 140),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...messages[index],
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 241, 241),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) => sendMessage(
                              value,
                              index,
                              func,
                            ),
                            controller: messageController,
                            decoration: InputDecoration.collapsed(
                              hintText: 'Type here...',
                              hintStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(color: Colors.black.withOpacity(0.2)),
                        const Gap(15),
                        Row(
                          children: [
                            Icon(
                              Icons.mood,
                              size: 25,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const Gap(17),
                            Icon(
                              Icons.photo_camera,
                              size: 25,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOnlineOrOffline() {
    int rand = Random().nextInt(2) + 1;
    switch (rand) {
      case 1:
        {
          return const Text(
            "Online",
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 58, 158, 62),
            ),
          );
        }
      default:
        {
          return const Text(
            "Offline",
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          );
        }
    }
  }
}
