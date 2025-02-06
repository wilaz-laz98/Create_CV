class Club:
    def __init__(self, name=None, description=None, role=None):
        self._name = '' if name == None else name
        self._description = '' if description == None else description
        self._role = '' if role == None else role

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def description(self):
        return self._description

    @description.setter
    def description(self, value):
        self._description = value

    @property
    def role(self):
        return self._role

    @role.setter
    def role(self, value):
        self._role = value
