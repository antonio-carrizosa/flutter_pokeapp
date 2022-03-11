import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key, this.text, this.retry}) : super(key: key);

  final String? text;
  final void Function()? retry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                "OPPS! \n Something went wrong.",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              if (text != null) const SizedBox(height: 10),
              if (text != null)
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              if (retry != null) const SizedBox(height: 10),
              if (retry != null)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).errorColor,
                    ),
                    onPressed: retry,
                    child: const Text("Retry"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
