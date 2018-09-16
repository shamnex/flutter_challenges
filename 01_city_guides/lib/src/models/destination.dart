import 'package:challenges/data/constants.dart';
import 'package:challenges/src/models/story.dart';

class Destination {
  final String title;
  final String image;
  final String description;
  final int temperature;
  final List<Story> stories;

  Destination(
      {this.title,
      this.image,
      this.description,
      this.temperature,
      this.stories});

  static List<Destination> generate() {
    return [
      Destination(
        title: "Link Louise",
        image: DestinationImages.one,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod ,",
        temperature: 23,
        stories:Story.generate(),
      ),
      Destination(
        title: "China Town",
        image: DestinationImages.two,
        description:
            "Lorem ipsum dolor sit adunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,",
        temperature: 18,
        stories:Story.generate(),
      ),
      Destination(
        title: "San Francisco",
        image: DestinationImages.three,
        description:
            "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,",
        temperature: 40,
        stories:Story.generate(),
      ),
      Destination(
        title: "Paris",
        image: DestinationImages.four,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do et dolore magna aliqua. Ut enim ad minim veniam,",
        temperature: 10,
        stories:Story.generate(),
      ),
    ];
  }
}
