import 'package:flutter/material.dart';
class tracking{

  Widget track(){
    return Row(
      children: [
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.greenAccent,
          child:Icon(Icons.transfer_within_a_station,color: Colors.white,),
        ),
        Expanded(
          child: Divider(
            thickness: 3,
            color: Colors.greenAccent,
            indent: 10,
            endIndent: 10,
            height: 10,
          ),
        ),
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.greenAccent,
          child:Icon(Icons.location_on,color: Colors.white,),
        ),
        Expanded(
          child: Divider(
            thickness: 3,
            color: Colors.greenAccent,
            indent: 10,
            endIndent: 10,
            height: 10,
          ),
        ),
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.greenAccent,
          child:Icon(Icons.details,color: Colors.white,),
        ),
        Expanded(
          child: Divider(
            thickness: 3,
            color: Colors.greenAccent,
            indent: 10,
            endIndent: 10,
            height: 10,
          ),
        ),
        SizedBox(width: 10,),
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child:Icon(Icons.payments_outlined,color: Colors.white,),
        ),
        SizedBox(width: 10,),


      ],
    );
  }

}