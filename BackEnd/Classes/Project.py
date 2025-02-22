class Project:
    def __init__(self, name=None, goal=None, key_tech=None, tasks=None):
        self._name = '' if name == None else name
        self._goal = '' if goal == None else goal
        self._key_tech = [] if key_tech == None else key_tech
        self._tasks = [] if tasks == None else tasks
    @staticmethod
    def question():
        return {
            "name": "What is the name of the project?",
            "goal": "What was the goal of the project?",
            "key_tech": "What key technologies did you use?",
            "tasks": "What were your tasks?"
        }

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def goal(self):
        return self._goal

    @goal.setter
    def goal(self, value):
        self._goal = value

    @property
    def key_tech(self):
        return self._key_tech

    @key_tech.setter
    def key_tech(self, value):
        self._key_tech.append(value)

    @property
    def tasks(self):
        return self._tasks

    @tasks.setter
    def tasks(self, value):
        self._tasks.append(value)
