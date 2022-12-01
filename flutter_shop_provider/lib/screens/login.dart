import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome',
                  style:
                      TextStyle(fontSize: 19, fontFamily: '[Corben]')), // 외부 폰트
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('ENTER',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontFamily: '[Corben]')), // 외부 폰트
              )
            ],
          ),
        ),
      ),
    );
  }
}
