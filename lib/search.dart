import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.check, color: Colors.white, size: 15),
                  ),
                  const SizedBox(width: 10),
                  const Text('I want to', style: TextStyle(fontSize: 16)), // Body text size
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('buy'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('rent'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blue),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('City', style: TextStyle(fontSize: 16)), // Body text size
                      Text('Colombo', style: TextStyle(color: Colors.blue, fontSize: 14)), // Body text size
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: Colors.black),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.home, color: Colors.blue),
                  const SizedBox(width: 10),
                  const Text('Property Type', style: TextStyle(fontSize: 16)), // Body text size
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10.0, // gap between adjacent chips
                runSpacing: 10.0, // gap between lines
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Commercial'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Residential'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Retail'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Vacational'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Apartments'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14), // Button text size
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.attach_money, color: Colors.blue),
                  const SizedBox(width: 10),
                  const Text('Price Range', style: TextStyle(fontSize: 16)), // Body text size
                  const Spacer(),
                  const Text('Rs.', style: TextStyle(color: Colors.blue, fontSize: 16)), // Body text size
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14), // Body text size
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('to', style: TextStyle(fontSize: 14)), // Body text size
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 14), // Body text size
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.square_foot, color: Colors.blue),
                  const SizedBox(width: 10),
                  const Text('Area Range', style: TextStyle(fontSize: 16)), // Body text size
                  const Spacer(),
                  Row(
                    children: [
                      const Text('sq ft', style: TextStyle(color: Colors.blue, fontSize: 16)), // Body text size
                      const SizedBox(width: 5),
                      DropdownButton<String>(
                        items: <String>['1k', '2k', '3k', '4k', '5k', '6k'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(fontSize: 14)), // Body text size
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          // Implement your logic here
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement reset logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.blue),
                      ),
                      child: const Text('Reset', style: TextStyle(color: Colors.blue, fontSize: 14)), // Body text size
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement done logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Done', style: TextStyle(color: Colors.white, fontSize: 14)), // Body text size
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: '',
          ),
        ],
        currentIndex: 2, // Initially selected search icon
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueAccent,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          // Handle navigation logic here
        },
      ),
    );
  }
}

