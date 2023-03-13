# An app to help memory reinforcement in patients suffering from Early stage Dementia 

A flutter app which includes personalized cognitive games for better memory reinforcement and to-do reminders for Dementia patients. 
Visual and memory based games which are a fun haven for senior
citizens.  All the games will be based on crucial information to the patient (collected through a query form and stored in firebase database ) thus, cognitive reinforcement is emphasized.
 features include :
1. Word Search:
Classic word search game with a grid of letters and the user has to find key words or answers based on the hints on the hints page 

2. Reverse spell:
 User has to type the reverse spelling of the word thrown at him / her by the app (voice cue).  User can click on repeat word to hear the word again . 
 
3. Picture Quiz: 
Visual based questionnaire for visual memory reinforcement. Implemented a dashboard to track the number of right and wrong answers.

4. To-do reminders: 
User can create a to-do check list , tick off tasks , add new tasks and delete old ones(not integrated with firebase datababse yet)


**Step 1:**

Download or clone this repo 

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 

```

Run it on release mode 

```
flutter run --release 
```

then choose web mode (the app only runs on web mode as of now)

## App demo of each feature is included in the file app-demo ##

## Have to work on :

1. Implementing Google Auth for Mac 
2. Fixing "Plugin with id 'com.google.gms.google-servicies' not found" error 
Have tried fixes :
https://stackoverflow.com/a/42174335
https://stackoverflow.com/a/47171000
3. Fix Gradel Task assemble release 

