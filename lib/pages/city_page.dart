import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final TextEditingController textEditControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/city.jpg'),
                    fit: BoxFit.cover)),
            child: Container(
              decoration: const BoxDecoration(color: Colors.black45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textEditControl,
                      onTap: () {},
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, size: 28),
                          fillColor: Colors.white24,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.teal,
                              width: 3,
                            ),
                          ),
                          helperText: '',
                          helperStyle: const TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                          ),
                          hintText: 'Шаарды жаз',
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context, textEditControl.text);
                    },
                    child: const Text(
                      'Шаарды изде',
                      style: TextStyle(fontSize: 50, color: Colors.white),
                    ),
                  )
                ],
              ),
            )),
      ]),
    );
  }
}
