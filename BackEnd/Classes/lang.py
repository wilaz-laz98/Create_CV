class Language:
    def __init__(self, language=None, level=None):
        self._language = '' if language == None else language
        self._level = '' if level == None else level

    @property
    def language(self):
        return self._language

    @language.setter
    def language(self, value):
        self._language = value

    @property
    def level(self):
        return self._level

    @level.setter
    def level(self, value):
        if value is not "beginner" or "re-Intermediate" or "intermediate" or "upper-Intermediate" or "advanced":
            raise ValueError
        self._level = value
