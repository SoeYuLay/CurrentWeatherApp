import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        color: Colors.black
      ), constraints: BoxConstraints.expand(),
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,)
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            // icon: Icon(Icons.location_city,color: Colors.white),
                            suffixIcon: TextButton(onPressed: (){
                              Navigator.pop(context,cityName);
                            },
                                child: Icon(Icons.search,color: Colors.grey,size: 30,)),
                            hintText: 'Enter City Name',
                            hintStyle: TextStyle(
                                color: Colors.grey
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none
                            )
                        ),
                        onChanged: (value){
                          cityName = value;
                        },
                      ),
                    ),
                  ],
                ),
              )),
    ),
    );
  }
}
