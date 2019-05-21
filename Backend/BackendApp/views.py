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

# handle all requests at .../loginStudent/
def auth_login(request):
    # Only POSTing to .../loginStudent/
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


# handle all requests at .../newStudent/
def newStudent(request):
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

@login_required # so that someone cannot access this method without having logged in
def handleData(request):
    hash_id = request.user.hash_id
    # Decode request body content
    content = QueryDict(request.body.decode('utf-8')).dict()
    if request.method == "GET":
        courses = {}
        sports = {}
        # Music lessons are text boxes filled in by user after they have spoken w/ music department

        # Propogate memories to return to frontend
        for course in Course.objects.all():
            courses[course.id] = {"title": course.title, "period": course.period, "teacher": course.teacher, "section": course.section, "room": course.room, "days": course.days}

        for sport in Sport.objects.all():
            sports[sport.id] = {"title": sport.title, "description": sport.description, "days": sport.days, "teacher": sport.teacher}

        data = {courses, sports}
        # Return data to frontend
        return JsonResponse(data, status=200)

@login_required
def handleCourseRequests(request):

    hash_id = request.user.hash_id

    if request.method == "GET":
        data = {}

        # Propogate memories to return to frontend
        for courseRequest in CourseRequest.objects.filter(hash_id = hash_id):
            data[courseRequest.id] = {"courses": courseRequest.courses, "topPriority": courseRequest.topPriority, "sport": courseRequest.sport, "musicLesson": courseRequest.musicLesson, "comments": courseRequest.comments}

        # Return data to frontend
        return JsonResponse(data, status=200)

    if request.method == "POST":
        # Decode request body content
        content = QueryDict(request.body.decode('utf-8')).dict()

        courses = content["courses"]
        topPriority = content["topPriority"]
        sport = content["sport"]
        musicLesson = content["musicLesson"]
        comments = content["comments"]

        # Create a CourseRequest object and save its reference to access id
        courseRequest = CourseRequest(hash_id = hash_id, courses = courses, topPriority = topPriority, sport = sport, musicLesson = musicLesson, comments = comments)
        courseRequest.save()

def auth_logout(request):
    logout(request)
