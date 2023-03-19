import 'package:flutter/material.dart';
import '../model/menus.dart';

class InfoDesignWidget extends StatefulWidget
{
  Menus? model;
  BuildContext? context;

  InfoDesignWidget({this.model, this.context});

  @override
  _InfoDesignWidgetState createState() => _InfoDesignWidgetState();
}



class _InfoDesignWidgetState extends State<InfoDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        // Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 280,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.model!.thumbnailUrl!,
                  height: 220.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 1.0,),
              Text(
                widget.model!.menuTitle!,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 40,
                  fontFamily: "Train",
                ),
              ),
              // Text(
              //   widget.model!.menuInfo!,
              //   style: const TextStyle(
              //     color: Colors.grey,
              //     fontSize: 20,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
