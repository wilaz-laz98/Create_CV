import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:frontend/src/Utils/utils.dart';
import 'package:frontend/src/theme/app_theme.dart';

class CvAddPage extends StatefulWidget {
  const CvAddPage({super.key});

  @override
  State<CvAddPage> createState() => _CvAddPageState();
}

class _CvAddPageState extends State<CvAddPage> {
  // showing entry script
  bool _showScript = true;
  String displayText = '';
  // list of templates to choose from
  Map<String, String> _templates = {};
  // selected template
  String _selectedTemplate = '';

  int progress = 0;
  Map<String, dynamic> questions = {};
  List<Map<String, String>> _questionsList = [];
  Map<String, dynamic> _answers = {};
  // Text Field Controller
  final TextEditingController _controller = TextEditingController();

  Future<void> _getTemplates() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/get_templates'));

    // print(jsonDecode(response.body)['templates']);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _templates = Map<String, String>.from(data['templates']);
        print("_getTemplates was executed :");
        print("Templates: $_templates");
      });
    } else {
      throw Exception('Failed to load templates');
    }
  }

  Future<void> _showTemplateDialog() async {
    await _getTemplates();
    final template = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a Template'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _templates.keys.map((template) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(template);
                  },
                  child: Text(template),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (template != null) {
      setState(() {
        _selectedTemplate = template;
        // print('selected template: $_selectedTemplate');
        _getQuestions();
        _showScript = false;
      });
    }
  }

  Future<void> _getQuestions() async {
    // print('template: $_selectedTemplate');
    final response = await http.get(
      Uri.parse('http://127.0.0.1:5000/get_questions'),
      headers: {
        'template': _selectedTemplate,
      },
    );
    // print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        questions =  Map<String, dynamic>.from(data['questions']);
        print('questions: $questions');
        _populateQuestions();
      });
    } else {
      throw Exception(
          'Failed to load questions, Error: ${response.statusCode}');
    }
  }

  void _populateQuestions()  {
    questions.forEach((category, questionSet) {
      if (questionSet is List) {
        for (var question in questionSet) {
          _questionsList.add(question);
        }
      } else if (questionSet is Map) {
        questionSet.forEach((question, text) {
          _questionsList.add({question: text});
        });
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        _answers[_questionsList[progress].keys.first] = _controller.text;
        _controller.clear();
        if (progress < _questionsList.length - 1) {
          progress++;
        } else {
          print("all answers completed : $_answers");
          // _submitAnswers();
        }
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (progress > 0) {
        progress--;
        _controller.text = _answers[_questionsList[progress].keys.first] ?? '';
      }
    });
  }

  void _script() {
    Utils.startTyping("Hi, Let's start working on your CV", (updatedText) {
      setState(() {
        displayText = updatedText;
      });
    });
    Timer(Duration(seconds: 5), () {
      Utils.startTyping('You will be completing a series of questions.',
          (updatedText) {
        setState(() {
          displayText = updatedText;
        });
      });
    });
    Timer(Duration(seconds: 10), () {
      Utils.startTyping('Check your progress in the progress bar above ^',
          (updatedText) {
        setState(() {
          displayText = updatedText;
        });
      });
    });
    Timer(Duration(seconds: 16), () {
      Utils.startTyping("let's get Started !)", (updatedText) {
        setState(() {
          displayText = updatedText;
        });
      });
    });
  }

  Widget _questionTypes(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => print("helloworld"), child: Text("Personal")),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => print("helloworld"), child: Text("Education")),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => print("helloworld"), child: Text("Experience")),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => print("helloworld"), child: Text("Projects")),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
              onPressed: () => print("helloworld"), child: Text("other")),
        ),
      ],
    );
  }


  @override
  void initState() {
    super.initState();
    _script();
  }

  @override
  Widget build(BuildContext context) {
    // String questionText = _questionsList[progress].values.first ;
    // double progress1 = (progress + 1) / _questionsList.length ;

    String questionText = 'No questions available';
    double progress1 = 0.0;

    // Check if _questionsList is not empty
    if (_questionsList.isNotEmpty) {
      // Ensure progress is within valid range
      if (progress >= 0 && progress < _questionsList.length) {
        questionText = _questionsList[progress].values.first;
        progress1 = (progress + 1) / _questionsList.length;
      }
    }
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
                child: _showScript
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            displayText,
                            style: AppTheme.darkTheme.textTheme.headlineMedium,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _showTemplateDialog,
                            child: Text('Start'),
                          )
                        ],
                      ))
                    : Column(
                        children: <Widget>[
                          LinearProgressIndicator(value: progress1),
                          SizedBox(height: 30),
                          _questionTypes(context),
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.all(100),
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color:
                                      AppTheme.darkTheme.colorScheme.onPrimary),
                            ),
                            child: Column(children: [
                              Text(
                                questionText,
                                style:
                                    AppTheme.darkTheme.textTheme.headlineMedium,
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: _controller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'your answer'),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  if (progress > 0)
                                    ElevatedButton(
                                      onPressed: _previousQuestion,
                                      child: Text('Previous'),
                                    ),

                                  ElevatedButton(
                                    onPressed: _nextQuestion,
                                    child: Text('Next'),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ],
                      ))));
  }
}
