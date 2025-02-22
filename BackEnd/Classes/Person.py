


class Person:
    def __init__(self,  email, password, user_name=None  ):
        self._email = email
        self._password = password
        self._user_name = "" if user_name == None else user_name

        self._cvs = {}


    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = value

    @property
    def password(self):
        return self._password

    @password.setter
    def password(self, value):
        self._password = value

    @property
    def user_name(self):
        return self._user_name

    @user_name.setter
    def user_name(self, value):
        self._user_name = value

    @property
    def cvs(self):
        return self._cvs

    @cvs.setter
    def cvs(self, value):
        self._cvs.append(value)
