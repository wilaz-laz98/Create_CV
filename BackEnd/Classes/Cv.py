
from abc import ABC

from .Education import Education
from .Experience import Experience
from .Project import Project
from .TechSkill import TechSkill
from .lang import Language


class Cv(ABC):
    def __init__(self, person, file_name=None,
                 first_name=None, last_name=None, title=None,
                 motivation=None, email=None, phone_num=None,
                 linkedin_account=None, github_account=None,
                 educations=None, experiences=None,
                 projects=None, clubs=None,
                 technical_skills=None, languages=None,
                 intrests=None,):

        self._person = person
        self._file_name = "default" if file_name == None else file_name
        self._first_name = "" if first_name == None else first_name
        self._last_name = "" if last_name == None else last_name
        self._title = "" if title == None else title
        self._motivation = "" if motivation == None else motivation
        self._email = "" if email == None else email
        self._phone_num = "" if phone_num == None else phone_num
        self._educations = [] if educations == None else educations
        self._experiences = [] if experiences == None else experiences
        self._languages = [] if languages == None else languages
    @staticmethod
    def questions():
        return {
            "Personal Infos": {
                "First Name": "What is your first name?",
                "Last Name": "What is your last name?",
                "Job Title": "What is your job title?",
                "Motivation": "What motivates you?",
                "E-mail": "What is your e-mail?",
                "Phone Number": "What is your phone number?",
            },
            "Educations": Education.question(),
            "Experiences": Experience.question(),
            "Languages" : Language.question(),
        }

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
    def languages(self):
        return self._languages

    @languages.setter
    def languages(self, value):
        self._languages.append(value)


class BasicTemplateForStem(Cv):
    def __init__(self, person = None, file_name=None,
                 first_name=None, last_name=None, title=None,
                 motivation=None, email=None, phone_num=None,
                 linkedin_account=None, github_account=None,
                 educations=None, experiences=None,
                 projects=None,
                 technical_skills=None, languages=None,):
        super().__init__(person , file_name,
                 first_name , last_name , title,
                 motivation , email , phone_num ,
                 educations , experiences , languages ,)
        self._linkedin_account = "" if linkedin_account == None else linkedin_account
        self._github_account = "" if github_account == None else github_account
        self._projects = [] if projects == None else projects
        self._technical_skills = [] if technical_skills == None else technical_skills

    @staticmethod
    def questions():
        questions = Cv.questions()
        questions["Personal Infos"].update({
            "LinkedIn Account": "What is your LinkedIn account?",
            "GitHub Account": "What is your GitHub account?",
        })
        questions.update({
            "Projects": Project.question(),
            "Technical Skills": TechSkill.question(),
        })

        return questions

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
    def projects(self):
        return self._projects

    @projects.setter
    def projects(self, value):
        self._projects.append(value)

    @property
    def technical_skills(self):
        return self._technical_skills

    @technical_skills.setter
    def technical_skills(self, value):
        self._technical_skills.append(value)
