import Person as p
class Cv:
    def __init__(self, file_name=None, person=None, template=None):
        self._file_name = "default" if file_name == None else file_name
        self._person = p() if person == None else person
        self._template = "default" if template == None else template

    @property
    def file_name(self):
        return self._file_name

    @file_name.setter
    def file_name(self, value):
        self._file_name = value

    @property
    def person(self):
        return self._person

    @person.setter
    def person(self, value):
        self._person = value

    @property
    def template(self):
        return self._template

    @template.setter
    def template(self, value):
        self._template = value
