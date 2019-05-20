import django.contrib.auth
from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, JsonResponse, QueryDict
from django.urls import include, path
from rest_framework import routers
from API_proj2app.models import *
from django.contrib.auth import login, logout
from django.contrib.auth import authenticate
from . import serializers # serializers.py, which we created
#from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required


# request data will be storied in request's body
def welcome(request):
    return HttpResponse("Welcome")

# handle all requests at .../login/
def auth_login(request):
    # Only POSTing to .../login/
    # from https://stackoverflow.com/questions/29780060/trying-to-parse-request-body-from-post-in-django

    if request.method == "POST":
        content = QueryDict(request.body.decode('utf-8')).dict() # content should be dict now
        student = django.contrib.auth.authenticate(username=content["username"], password=content["password"])
        if user:
            login(request,student) #django's built in
            # serializer = serializers.UserSerializer(user)
            # print(serializer)
            return JsonResponse({'status':'true','message':"Logged in", "hash_id":student.hash_id}, status=200)

        return JsonResponse({'status':'false','message':"Invalid username and/or password"}, status=406)


# handle all requests at .../newUser/
def newUser(request):
     # Only POST
    content = QueryDict(request.body.decode('utf-8')).dict() #access content from request
    firstName = content["firstName"]
    lastName = content["lastName"]
    studentEmail = content["studentEmail"]
    advisorEmail = content["advisorEmail"]
    password = content["password"]
    if request.method == "POST":
        if User.objects.filter(username = username).exists():
            return JsonResponse({'status':'false','message':"This student email is already in use"}, status=406)
        try:
            new_student = Student(firstName = firstName, lastName = lastName, studentEmail = studentEmail,
                                    advisorEmail = advisorEmail)
            new_student.set_password(password)
        except:
            return JsonResponse({'status':'false', 'message':"Invalid username or password"}, status=406)
        # serializer = serializers.UserSerializer(new_user)
        new_student.save()
        return JsonResponse({'status':'true', 'message':"Your account has been created, please login", "hash_id": new_student.hash_id}, status=201) #201 -> new resource created

# handle all requests at .../memories/
@login_required # so that someone cannot access this method without having logged in
def handleCourses(request):

    # need to define this
    # question - would we load the data only here?
    return

def auth_logout(request):
    logout(request)
