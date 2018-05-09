# !/bin/sh

# Creating new app
mkdir ${1}
cd ${1}

# create virtual enviromment
python3 -m venv virtual

# activate the virtual environment and install dependancies
source virtual/bin/activate
pip install django==1.11 #django-bootstrap4 django-heroku psycopg2 pillow gunicorn


# initiaize and configure folder to git
git init

touch .gitignore README.md requirements.txt


cat << EOF > .gitignore

virtual/
__pycache__
db.sqlite3
*.pyc

EOF

# create project

django-admin startproject ${1} .

# prompt user for app name 
echo "hello there lets give our first app a name? type in a name: "
read appname

echo "creating app " $appname "........."
# start app in project
python3 manage.py startapp $appname

cd $appname #navigate to the folder

mkdir templates #make templates folder

# getting into folder and creating templates
cd templates

touch base.html

cat << EOF > base.html

{% load bootsrap4%}
{% load static%}
<!DOCTYPE html>
<html lang="en">
<head>
    {% block styles%}
        <link rel="shortcut icon" href="{%'favicon.ico%'}" type="image/x-icon">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
    {% endblock %}
    <title>Document</title>
</head>
<body>
    {% block content %}
    {% endblock %}

    {%block scripts%}
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    {% end block %}
</body>
</html>

EOF

# getting out of templates 
cd ..

mkdir static

# cange into static and create folder
cd static
mkdir css images

cd ..

# creating urlsConf for application

touch urls.py

# enter text in urls.py

cat << EOF > urls.py

from django.conf.urls import url
from . import views

# put your urls here 

urlpatterns = [
    url(r'^$', views.index, name='index'),
]

EOF


# create view in views.py 

cat << EOF >> views.py 

def index(request):
    return render(request, '', {})

EOF

# get out of app folder
cd ..

touch Procfile

cat << EOF > Procfile
web: gunicorn ${1}.wsgi --log-file-

EOF

git add .
git commit -m "file structure"



# open in vs
code .

python3 manage.py runserver