class Education:
    def __init__(self, start_date=None, end_date=None, degree=None, school=None, location=None):
        self._start_date = '' if start_date == None else start_date
        self._end_date = '' if end_date == None else end_date
        self._degree = '' if degree == None else degree
        self._school = '' if school == None else school
        self._location = '' if location == None else location
    @staticmethod
    def question():
        return {#TODO :make it a list and see what goes?
            "start_date": "When did you start this education?",
            "end_date": "When did you finish this education?",
            "degree": "What degree did you get?",
            "school": "What school did you attend?",
            "location": "Where was the school located?"
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
    def degree(self):
        return self._degree

    @degree.setter
    def degree(self, value):
        self._degree = value

    @property
    def school(self):
        return self._school

    @school.setter
    def school(self, value):
        self._school = value

    @property
    def location(self):
        return self._location

    @location.setter
    def location(self, value):
        self._location = value
