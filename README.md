# APP
Task management App : Simple task management app with backend in node js.

## Getting Started
This project is created in flutter using getx state management. It support both web and mobile app.
This project backend is created in nodeJs which you can check in ``` task-management-flutter/backend ``` folder.


## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/KishanBusa8/task-management-flutter.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies for flutter:

```
flutter pub get 
```

Go to project root/backend and execute the following command in console to get the required dependencies for backend:
[node version is 20+]
```
npm install
```

## App Features:

* Splash
* Login
* Register
* Home
* Routing
* Theme
* GetX (State Management)
* Validation
* Dark Theme Support 
* Multilingual Support 
* Add, Update and delete Task
* Filter task by status

## Backend Features:

* Auth apis
* Authentication
* Passport
* JWT
* MongoDB
* Add, Update, delete Task API
* Get all Task api
* Error handling
* Schema Validations


### Libraries & Tools Used

**Flutter**
* [get](https://pub.dev/packages/get) => For state management
* [get_storage](https://pub.dev/packages/get_storage) => For local storage
* [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) => For check if internet is available or not
* [panara_dialogs](https://pub.dev/packages/panara_dialogs) => To show beautiful error or info dialogs
* [ftoast](https://pub.dev/packages/ftoast) => To show beautiful error or info toasts
* [flutter_slider_drawer](https://pub.dev/packages/flutter_slider_drawer) => Used for slide drawer

**Node**
* [bcryptjs](https://pub.dev/packages/get) => For has encrypt password
* [dotenv](https://pub.dev/packages/get) => For use env file
* [express](https://pub.dev/packages/express) 
* [jsonwebtoken](https://pub.dev/packages/jsonwebtoken) => For encrypt and decrypt auth token
* [mongoose](https://pub.dev/packages/mongoose) => MongoDB
* [passport](https://pub.dev/packages/mongoose) => Authentication management
* [validator](https://pub.dev/packages/validator) => Validations
* [joi](https://pub.dev/packages/joi) => Schema Validations


### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- app/
|- components/
|- helpers/
|- I10n/
|- main.dart
```


Now, lets dive into the lib folder which has the main code for the application.

```
1- app - All the application level Logic.
2- components - Contains all the project level reusable widgets.
3- helpers - All the application level constants, theme, translations, Contains the utilities/common functions of your application and lazy put for global level controllers define here.
4- I10n — All your translations text will be here.
5- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### app
All the business logic and UI part of your application will go into this directory, it represents the data and UI layer of your application.

```
app/
|- data/
   |- models/                          => All data model would be here
   |- services/                        => All services would be define here 
      |- apiService/                   => Api service for call apis
      |- global/                       => All global level controllers would be define here like `global`, `theme` and `language`
|- modules/                            => All the ui part and related business logic of the screen is define here
|- routes/                             => All the routes is define here
```



### Folder Structure Backend

```
backend/
|- config/
|- controllers/
|- middleware/
|- models/
|- routes/
|- utils/
|- validatin/
|- app.js
|- package.json

```
Now, lets dive into the lib folder which has the main code for the application.

```
1- config - All the configs define here like db related and passport auth related config.
2- controllers - Contains business logic of the app.
3- middleware - All the route middleware check is define here.
4- models — All your mongoose schema models are define here.
5- routes - All the API routes are define here.
6- utils - Contains the utilities/common functions of your application
7- validations - All the validation related auth, schema validations are define here.

```
