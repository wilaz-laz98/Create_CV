class TechSkill:
    def __init__(self, type=None, skill=None):
        self._type = '' if type == None else type
        self._skills = [] if skill == None else skill
    @staticmethod
    def question():
        return {
            "type": "What type of skill is this?",
            "skill": "What is the skill?"
        }

    @property
    def type(self):
        return self._type

    @type.setter
    def type(self, value):
        self._type = value

    @property
    def skill(self):
        return self._skills

    @skill.setter
    def skill(self, value):
        self._skills.append(value)
