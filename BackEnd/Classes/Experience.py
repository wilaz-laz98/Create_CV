class Experience:
    def __init__(self, start_date=None, end_date=None, position=None, company=None, tasks=None):
        self._start_date = '' if start_date == None else start_date
        self._end_date = '' if end_date == None else end_date
        self._position = '' if position == None else position
        self._company = '' if company == None else company
        self._tasks = [] if tasks == None else tasks
    @staticmethod
    def question():
        return {
            "start_date": "When did you start this experience?",
            "end_date": "When did you finish this experience?",
            "position": "What was your position?",
            "company": "What company did you work for?",
            "tasks": "What were your tasks?"
        }

    @property
    def start_date(self):
        return self._start_date

    @start_date.setter
    def start_date(self, value):
        self._start_date = value

    @property
    def end_date(self):
        return self._end_date

    @end_date.setter
    def end_date(self, value):
        self._end_date = value

    @property
    def position(self):
        return self._position

    @position.setter
    def position(self, value):
        self._position = value

    @property
    def company(self):
        return self._company

    @company.setter
    def company(self, value):
        self._company = value

    @property
    def tasks(self):
        return self._tasks

    @tasks.setter
    def tasks(self, value):
        self._tasks.append(value)
