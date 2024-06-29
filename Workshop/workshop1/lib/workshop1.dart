import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';



class ImageCarousel extends StatelessWidget {
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfj85Iy4pQCIB6QuE3eiDq8GfGGVB79bl4gw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhxZrGDQZC8CmUPALLLLclc-QCiFFzuVHFmQ&usqp=CAU ',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTO3_kswUyASOhJr0Skqc0Qiy1MGXJFMH-ifA&usqp=CAU ',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Carousel"),
      ),
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
          items: imgList.map((item) => Container(
            child: Center(
              child: Image.network(item, fit: BoxFit.cover, width: 1000),
            ),
          )).toList(),
        ),
      ),
    );
  }
}
