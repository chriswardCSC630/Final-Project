import django.contrib.auth
from django.shortcuts import render
from django.views import View
from django.http import HttpResponse, JsonResponse, QueryDict

# Create your views here.
class requestHandlers(View):
    # request data will be storied in request's body
    def welcome(request):
        return HttpResponse("Welcome")
