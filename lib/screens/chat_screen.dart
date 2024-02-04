// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/storage.dart';
import '../core/variables.dart';
import '../models/people.dart';
import '../services/api.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/people_item.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Kullanicinin bu sayfaya erisimi yoksa welcomeScreen'e gonderiyoruz.
  getUser() async {
    Storage storage = Storage();

    var user = await storage.loadUser();

    if (user == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/welcome", (route) => false);
    }
  }

  // Screen'imiz yuklendiginde auth ve kisileri yukleme fonksiyonlarimizi calistiriyoruz.
  @override
  void initState() {
    super.initState();
    setState(() {
      messages = [
        [...defaultMessages],
        [...defaultMessages],
        [...defaultMessages],
        [...defaultMessages],
        [...defaultMessages],
        [...defaultMessages],
      ];
    });
    getUser();
    getRandomPeople();
  }

  bool loading = false;

  forceUpdate() {
    setState(() {});
  }

  // API'dan gelen kisi bilgilerini alip state'imize yerlestiriyoruz.
  getRandomPeople() async {
    setState(() {
      loading = true;
    });

    API api = API();

    var users = await api.getUsersService();
    List usersData = users["data"];

    setState(() {
      peopleList.clear();
    });
    usersData.forEachIndexed((index, element) {
      setState(() {
        peopleList.add(
          People(
            name: "${element["first_name"]} ${element["last_name"]}",
            avatarUrl: element["avatar"],
            lastMessage: messages[index][messages[index].length - 1].message,
            dateTime: messages[index][messages[index].length - 1].time,
            unreadCount: 1,
          ),
        );
      });
    });

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingIndicator()
        : Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                color: const Color.fromARGB(255, 241, 241, 241),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        bottom: 5,
                        right: 20,
                        left: 20,
                      ),
                      child: topBar(),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: 5,
                        ),
                        child: ListView.builder(
                          itemCount: peopleList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PeopleItem(
                              people: peopleList[index],
                              index: index,
                              func: forceUpdate,
                            );
                          },
                        ),
                      ),
                    ),
                    bottomBar(context),
                  ],
                ),
              ),
            ),
          );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45),
          topRight: Radius.circular(45),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              Uri url = Uri.parse(
                  "https://github.com/siracyakut/bytebuilders-chat-app/");
              await launchUrl(url);
            },
            child: const Icon(
              Icons.language,
              size: 30,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          InkWell(
            onTap: () async {
              Uri url = Uri.parse("sms:+905538543421?body=Hello+ByteBuilders!");
              await launchUrl(url);
            },
            child: const Icon(
              Icons.forum,
              size: 30,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(112, 62, 254, 1),
              borderRadius: BorderRadius.circular(32.5),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(
                    112,
                    62,
                    254,
                    1,
                  ).withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              size: 45,
              color: Colors.white,
            ),
          ),
          InkWell(
            onTap: () async {
              Uri url = Uri.parse("tel:+905538543421");
              await launchUrl(url);
            },
            child: const Icon(
              Icons.call,
              size: 30,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, "/profile"),
            child: const Icon(
              Icons.person,
              size: 30,
              color: Color.fromARGB(255, 128, 128, 128),
            ),
          ),
        ],
      ),
    );
  }

  Widget topBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search,
                  size: 30,
                  color: Color.fromARGB(255, 128, 128, 128),
                ),
                Gap(15),
                Text(
                  "Search message...",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 128, 128, 128),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Gap(25),
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.edit_square,
            size: 30,
            color: Color.fromARGB(255, 128, 128, 128),
          ),
        ),
      ],
    );
  }
}
