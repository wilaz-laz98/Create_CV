import Education as edu
import Experience as exp
import Project as proj
import Club as cl
import TechSkill as ts
import lang
import Cv as cv


class Person:
    def __init__(self,  email, password, user_name=None,
                 first_name = None, last_name = None, title = None,
                   motivation = None, phone_num = None,
                     linkedin_account = None, github_account = None,
                       educations = None, experiences = None,
                         projects = None, clubs = None,
                            technical_skills = None, languages = None,
                                intrests = None,   ):
        self._email = ""
        self._password = ""
        self._user_name = "" if user_name == None else user_name
        self._first_name = "" if first_name == None else first_name
        self._last_name = "" if last_name == None else last_name
        self._title = "" if title == None else title
        self._motivation = "" if motivation == None else motivation
        self._phone_num = "" if phone_num == None else phone_num
        self._linkedin_account = "" if linkedin_account == None else linkedin_account
        self._github_account = "" if github_account == None else github_account
        self._educations = [edu] if educations == None else educations
        self._experiences = [exp] if experiences == None else experiences
        self._projects = [proj] if projects == None else projects
        self._clubs = [cl] if clubs == None else clubs
        self._technical_skills = [ts] if technical_skills == None else technical_skills
        self._languages = [lang] if languages == None else languages
        self._intrests = [] if intrests == None else intrests

        self._cvs = [cv]

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
    def educations(self, value: edu):
        self._educations.append(value)

    @property
    def experiences(self):
        return self._experiences

    @experiences.setter
    def experiences(self, value: exp):
        self._experiences.append(value)

    @property
    def projects(self):
        return self._projects

    @projects.setter
    def projects(self, value: proj):
        self._projects.append(value)

    @property
    def clubs(self):
        return self._clubs

    @clubs.setter
    def clubs(self, value: cl):
        self._clubs.append(value)

    @property
    def technical_skills(self):
        return self._technical_skills

    @technical_skills.setter
    def technical_skills(self, value: ts):
        self._technical_skills.append(value)

    @property
    def languages(self):
        return self._languages

    @languages.setter
    def languages(self, value: lang):
        self._languages.append(value)

    @property
    def intrests(self):
        return self._intrests

    @intrests.setter
    def intrests(self, value :str):
        self._intrests.append(value)

    @property
    def cvs(self):
        return self.cvs

    @intrests.setter
    def cvs(self, value: cv):
        self._intrests.append(value)
