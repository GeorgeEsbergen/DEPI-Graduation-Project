import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _videoFile;
  Map<String, dynamic>? _movieData;

  Future<void> _pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        _videoFile = File(video.path);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:5000/upload'),
    );
    request.files.add(await http.MultipartFile.fromPath('video', _videoFile!.path));
    
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      setState(() {
        _movieData = Map<String, dynamic>.from(json.decode(responseData));
      });
    } else {
      print('Failed to upload video: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Recognition App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: Text('Upload Video'),
            ),
            SizedBox(height: 20),
            if (_movieData != null) ...[
              Text('Movies Featuring Recognized Actors:', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var entry in _movieData!.entries) 
                Text('${entry.key}: ${entry.value.join(", ")}'),
            ],
          ],
        ),
      ),
    );
  }
}