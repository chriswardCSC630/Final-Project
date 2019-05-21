from django.db import models
from django.conf import settings
from decimal import Decimal
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField
import urllib
import json
from . import helper # we created this

# The Student model. The student_id is automatically generated
class Student(AbstractUser):

    hash_id = models.CharField(max_length=32, default=helper.create_hash, unique=True)

    firstName = models.CharField(max_length=30, default="none")
    lastName = models.CharField(max_length=30, default="none")
    advisorEmail = models.CharField(max_length=30, default="none")

    # studentEmail and password already in AbstractUser

    # for printing a Student object
    def __str__(self):
        return self.username + " name: " + self.firstname + " " + self.lastname + ""

class Course(models.Model):
    title = models.CharField(max_length=90, default="none")
    period = models.CharField(max_length=30, default="none")
    teacher = models.CharField(max_length=30, default="none")
    section = models.CharField(max_length=30, default="none")
    room = models.CharField(max_length=30, default="none")
    days = models.CharField(max_length=30, default="none")
    updated = models.CharField(max_length=60, default="unknown")
    # for printing a Course object
    def __str__(self):
        return self.title + " (" + self.teacher + " | period " + self.period + ")"

# Sports, like courses, should be a dropdown of sports offered
class Sport(models.Model):
    title = models.CharField(max_length=30, default="none")
    description = models.TextField()
    days = models.CharField(max_length=255, default="none")
    teacher = models.CharField(max_length=30, default="none")
    def __str__(self):
        return self.title + " (" + self.description + ")"

# Music lessons should be custom-filled out by user after they have talked to music department
class MusicLesson(models.Model):
    instrument = models.CharField(max_length=30, default="none")
    teacher = models.CharField(max_length=30, default="none")
    length = models.CharField(max_length=30, default="none")
    def __str__(self):
        return self.instrument + " (" + self.teacher + " | length: " + self.length + ")"

class CourseRequest(models.Model):
    # OneToOneField not allowed within ArrayField, thus 2D Array of CharField stores courses
    hash_id = models.CharField(max_length=32)
    courses = ArrayField(ArrayField(models.CharField(max_length=30, default="none"))) # ArrayFields from https://stackoverflow.com/questions/44630642/its-possible-to-store-an-array-in-django-model
    topPriority = models.OneToOneField(Course, on_delete=models.PROTECT)
    sport = models.OneToOneField(Sport, on_delete=models.PROTECT)
    musicLesson = models.OneToOneField(MusicLesson, on_delete=models.PROTECT)
    comments = models.TextField()
    def __str(self):
        return self.hash_id
