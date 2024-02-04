import '../models/people.dart';
import '../widgets/message_item.dart';

List<People> peopleList = [];

List<MessageItem> defaultMessages = [
  const MessageItem(
    message: "Hi mate! Any update today?",
    time: "09:32 PM",
    isMe: true,
  ),
  const MessageItem(
    message: "All good! We have some update.",
    time: "09:34 PM",
    isMe: false,
  ),
  const MessageItem(
    message:
        "Cool! I have some feedbacks on the 'How it work' section. But overall looks good now!",
    time: "09:34 PM",
    isMe: true,
  ),
];

List messages = [
  [...defaultMessages],
  [...defaultMessages],
  [...defaultMessages],
  [...defaultMessages],
  [...defaultMessages],
  [...defaultMessages],
];
