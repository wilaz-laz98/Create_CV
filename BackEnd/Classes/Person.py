

class Person:
    def __init__(self, user_name, password,
                 first_name = None, last_name = None, title = None,
                   motivation = None, email = None, phone_num = None,
                     linkedin_account = None, github_account = None,
                       educations = None, experiences = None,
                         projects = None, clubs = None,
                            technical_skills = None, languages = None,
                                intrests = None,   ):
        self._user_name = ""
        self._password = ""
        self._first_name = "" if first_name == None else first_name
        self._last_name = "" if last_name == None else last_name
        self._title = "" if title == None else title
        self._motivation = "" if motivation == None else motivation
        self._email = "" if email == None else email
        self._phone_num = "" if phone_num == None else phone_num
        self._linkedin_account = "" if linkedin_account == None else linkedin_account
        self._github_account = "" if github_account == None else github_account
        self._educations = [] if educations == None else educations
        self._experiences = [] if experiences == None else experiences
        self._projects = [] if projects == None else projects
        self._clubs = [] if clubs == None else clubs
        self._technical_skills = [] if technical_skills == None else technical_skills
        self._languages = [] if languages == None else languages
        self._intrests = [] if intrests == None else intrests

    @staticmethod
    def not_unique(value):
        pass

    @property
    def user_name(self):
        return self._user_name

    @user_name.setter
    def user_name(self, value):
        self._user_name = value

    @property
    def password(self):
        return self._password

    @user_name.setter
    def password(self, value):
        self._password = value

    @property
    def first_name(self):
        return self._first_name

    @first_name.setter
    def first_name(self, value):
        self._first_name = value

    @property
    def last_name(self):
        return self._last_name

    @last_name.setter
    def last_name(self, value):
        self._last_name = value

    @property
    def title(self):
        return self._title

    @title.setter
    def title(self, value):
        self._title = value

    @property
    def motivation(self):
        return self._motivation

    @motivation.setter
    def motivation(self, value):
        self._motivation = value

    @property
    def email(self):
        return self._email

    @email.setter
    def email(self, value):
        self._email = value

    @property
    def phone_num(self):
        return self._phone_num

    @phone_num.setter
    def phone_num(self, value):
        self._phone_num = value

    @property
    def linkedin_account(self):
        return self._linkedin_account

    @linkedin_account.setter
    def linkedin_account(self, value):
        self._linkedin_account = value

    @property
    def github_account(self):
        return self._github_account

    @github_account.setter
    def github_account(self, value):
        self._github_account = value

    @property
    def educations(self):
        return self._educations

    @educations.setter
    def educations(self, value):
        self._educations.append(value)

    @property
    def experiences(self):
        return self._experiences

    @experiences.setter
    def experiences(self, value):
        self._experiences.append(value)

    @property
    def projects(self):
        return self._projects

    @projects.setter
    def projects(self, value):
        self._projects.append(value)

    @property
    def clubs(self):
        return self._clubs

    @clubs.setter
    def clubs(self, value):
        self._clubs.append(value)

    @property
    def technical_skills(self):
        return self._technical_skills

    @technical_skills.setter
    def technical_skills(self, value):
        self._technical_skills.append(value)

    @property
    def languages(self):
        return self._languages

    @languages.setter
    def languages(self, value):
        self._languages.append(value)

    @property
    def intrests(self):
        return self._intrests

    @intrests.setter
    def intrests(self, value):
        self._intrests.append(value)
