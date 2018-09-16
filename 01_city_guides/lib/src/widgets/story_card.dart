import 'package:flutter/material.dart';
import 'package:challenges/data/constants.dart';
import 'package:challenges/src/models/story.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    Key key,
    @required this.story,
  }) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
      width: 230.0,
      
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                 padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                decoration: BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.teal.shade300,
                      Colors.teal,
                    ],
                  ),
                ),
                child: Text(
                  story.category.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                height: 50.0,
                child: Text(
                  story.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.boldText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  story.excerpt,
                  textAlign: TextAlign.left,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.bodyText,
                  ),
                ),
              ),
              
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(story.image),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                ),
              ),
              Divider(
                height: 20.0,
                color: AppColors.lightGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: "${story.places} ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' PLACES',
                          style: TextStyle(
                            color: AppColors.bodyText,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: AppColors.lightGrey,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                      ),
                      Icon(
                        Icons.share,
                        size: 14.0,
                        color: AppColors.lightGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

