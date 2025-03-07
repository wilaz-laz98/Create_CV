import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
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
  // progress of questions
  int categoryProgress = 0;
  int questionProgress = 0;
  // global question received from the server
  Map<String, dynamic> questions = {};
  // the main categories of the cv template, categories = [Personal info, Education, Work Experience, ...]
  List<String> _categories = [];
  // list of questions per category, questionlist = [{pesonal_question01: text, personal_question02: text, ...}, {education_question01: text, education_question02: text, ...}, ...]
  List<List<String>> _questionsList = [];
  // list of labels per category
  List<List<String>> _labelsList = [];
  // answers to the questions per category, answers = {"personal questions" :{personal_question01: answer, personal_question02: answer, ...}, "education questions" :{education_question01: answer, education_question02: answer, ...}, ...}
  Map<String, dynamic> _answers = {};
  // Text Field Controller
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _alterController = TextEditingController();

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
        questions = Map<String, dynamic>.from(data['questions']);
        _populateQuestions();
      });
    } else {
      throw Exception(
          'Failed to load questions, Error: ${response.statusCode}');
    }
  }

  Widget _highlightCategories(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < _categories.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      categoryProgress = i;
                      questionProgress = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: i == categoryProgress
                        ? AppTheme.darkTheme.colorScheme.secondary
                        : AppTheme.darkTheme.colorScheme.primary,
                  ),
                  child: Text(
                    _categories[i],
                    style: TextStyle(
                      color: i == categoryProgress
                          ? AppTheme.darkTheme.colorScheme.onSecondary
                          : AppTheme.darkTheme.colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _populateQuestions() {
    if (questions == null) {
      throw ('Questions object is null');
    }
    questions.forEach((category, questionSet) {
      _categories.add(category);
      List<String> tempQuestions = [];
      List<String> tempLabels = [];
      questionSet.forEach((label, question) {
        tempLabels.add(label);
        tempQuestions.add(question);
      });
      _labelsList.add(tempLabels);
      _questionsList.add(tempQuestions);
      print(_labelsList);
    });
  }

  void _nextQuestion() {
    setState(() {
      // prevent moving forward if controller is empty
      if (_controller.text.isNotEmpty) {
        // crete an empty set for entries of personal infos category
        if (_categories[categoryProgress] == "Personal Infos") {
          if (!_answers.containsKey(_categories[categoryProgress])) {
            _answers[_categories[categoryProgress]] = {};
          }
          // save the answers of personal infos
          _answers[_categories[categoryProgress]]
                  [_labelsList[categoryProgress][questionProgress]] =
              _controller.text;
        } else {
          // create an empty list for ansewrs of categories other than personal infos
          if (!_answers.containsKey(_categories[categoryProgress])) {
            _answers[_categories[categoryProgress]] = [];
          }
          // add an empty map for an entry of category other than personal infos if list is empty or we already completed the last entry
          if ((_answers[_categories[categoryProgress]]?.isEmpty ?? true) ||
              _answers[_categories[categoryProgress]]!.last.length ==
                  _questionsList[categoryProgress].length) {
            _answers[_categories[categoryProgress]]!.add({});
          }
          // save an entry of categories other than personal infos
          _answers[_categories[categoryProgress]]!
                  .last[_labelsList[categoryProgress][questionProgress]] =
              _controller.text;
        }

        // next question
        questionProgress++;

        // if questions per category are complete
        if (questionProgress >= _questionsList[categoryProgress].length) {
          // reset question counter
          questionProgress = 0;
          // for categories other than personal infor show add more prompt
          if (_categories[categoryProgress] != "Personal Infos") {
            _showAddMorePrompt();
          } else {
            //progress to next category
            categoryProgress++;
          }
        }
        _controller.clear();
      }
    });
    print(_answers);
  }

  void _showAddMorePrompt() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Another Entry?'),
          content: Text('Do you want to add another entry for this category?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  // _isCategoryQuestionsComplete = true;
                  categoryProgress++;
                });
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  questionProgress = 0;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _addMore() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        if (_categories[categoryProgress] == "Personal Infos") {
          if (!_answers.containsKey(_categories[categoryProgress])) {
            _answers[_categories[categoryProgress]] = {};
          }
          _answers[_categories[categoryProgress]]
                  [_labelsList[categoryProgress][questionProgress]] =
              _controller.text;
        } else {
          if (!_answers.containsKey(_categories[categoryProgress])) {
            _answers[_categories[categoryProgress]] = [];
          }

          if ((_answers[_categories[categoryProgress]]?.isEmpty ?? true) ||
              _answers[_categories[categoryProgress]]!.last.length ==
                  _questionsList[categoryProgress].length) {
            _answers[_categories[categoryProgress]]!.add({});
          }

          _answers[_categories[categoryProgress]]!
                  .last[_labelsList[categoryProgress][questionProgress]] =
              _controller.text;
          questionProgress = 0;
        }

        _controller.clear();
      }
    });
    // print(_answers);
  }

  void _previousQuestion() {
    setState(() {
      if (questionProgress > 0) {
        questionProgress--;
      } else {
        categoryProgress--;
        questionProgress = _questionsList[categoryProgress].length - 1;
      }
    });
    print(_answers);
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

  Widget _answersPreview() {
    return Container(
      width: 450,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.darkTheme.colorScheme.onPrimary),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text('Answers Preview',
              style: AppTheme.darkTheme.textTheme.headlineMedium),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: _answers.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final answers = _answers[category];
                return Column(
                  children: [
                    Text(category,
                        style: AppTheme.darkTheme.textTheme.headlineSmall),
                    SizedBox(height: 10),
                    if (category == "Personal Infos")
                      Column(
                        children: [
                          for (var label in answers.keys)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(label,
                                    style: AppTheme
                                        .darkTheme.textTheme.headlineSmall),
                                TextButton(
                                  onPressed: () {
                                    _showChangePrompt(category, label);
                                  },
                                  child: Text(answers[label],
                                      style: AppTheme
                                          .darkTheme.textTheme.headlineSmall),
                                )
                              ],
                            ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          for (var answerSet in answers)
                            Column(
                              children: [
                                for (var label in answerSet.keys)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(label,
                                          style: AppTheme.darkTheme.textTheme
                                              .headlineSmall),
                                      TextButton(
                                        onPressed: () {
                                          _showChangeDeletePrompt(
                                              category, answerSet, label);
                                        },
                                        child: Text(answerSet[label],
                                            style: AppTheme.darkTheme.textTheme
                                                .headlineSmall),
                                      )
                                    ],
                                  ),
                                Text('______________'),
                              ],
                            ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeDeletePrompt(category, set, label) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('change value'),
              content: Container(
                height: 100,
                width: 300,
                child: Column(
                  children: [
                    Text(label),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _alterController,
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            (_answers[category] as List<dynamic>)
                                .removeWhere((entry) => entry == set);
                          });
                          questionProgress = 0;
                          Navigator.of(context).pop();
                        },
                        child: Text("Delete")),
                    ElevatedButton(
                        onPressed: () {
                          // [_labelsList[categoryProgress][questionPrrogress]]
                          final int categoryprog =
                              _categories.indexOf(category);
                          final int setNum = _answers[category].indexOf(
                              set); // print("categoryprog : $categoryprog");
                          final int labelprog =
                              _labelsList[categoryprog].indexOf(label);
                          // print("labelprog : $labelprog");
                          setState(() {
                            _answers[category][setNum]
                                    [_labelsList[categoryprog][labelprog]] =
                                _alterController.text;
                          });
                          // print(_answers);
                          _alterController.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text("change")),
                  ],
                ),
              ]);
        });
  }

  void _showChangePrompt(category, label) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('change value'),
              content: Container(
                height: 100,
                width: 300,
                child: Column(
                  children: [
                    Text(label),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _alterController,
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      // [_labelsList[categoryProgress][questionPrrogress]]
                      final int categoryprog = _categories.indexOf(category);
                      // print("categoryprog : $categoryprog");
                      final int labelprog =
                          _labelsList[categoryprog].indexOf(label);
                      // print("labelprog : $labelprog");
                      setState(() {
                        _answers[category]
                                [_labelsList[categoryprog][labelprog]] =
                            _alterController.text;
                      });
                      // print(_answers);
                      _alterController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("change")),
              ]);
        });
  }

  Widget _saveProgress() {
    return Container (
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ElevatedButton(
              onPressed: ()=>print("hello world"),
              child: Text("Exit")
            ),
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () => print("hello world"),
              child: Text("Save Progress"),
            ),
          ),
        ]
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _script();
  }

  @override
  Widget build(BuildContext context) {
    String questionText = 'No questions available';
    double progress1 = 0.0;

    if (_questionsList.isNotEmpty) {
      if (categoryProgress >= 0 && categoryProgress < _categories.length) {
        questionText = _questionsList[categoryProgress][questionProgress];
        progress1 = (categoryProgress + 1) / _categories.length;
      }
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
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
                    : Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                LinearProgressIndicator(value: progress1),
                                Flexible(
                                  flex: 1,
                                  child: _highlightCategories(context),
                                ),
                                Flexible(
                                  flex: 4,
                                  child: Center(
                                    child: Container(
                                      height: 200,
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppTheme.darkTheme
                                                .colorScheme.onPrimary),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            questionText,
                                            style: AppTheme.darkTheme.textTheme
                                                .headlineMedium,
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
                                              if (questionProgress > 0)
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

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: _saveProgress()
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: _answersPreview(),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
