from django.db import models
from django.conf import settings
from decimal import Decimal
from django.contrib.auth.models import AbstractUser
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

    # for displaying a user objects
    def __str__(self):
        return self.username + " (name: " + self.firstname + " " + self.lastname + ")"
