1. What are the different genres?

Book
Business
Education
Entertainment
Finance
Food & Drink
Games
Health & Fitness
Lifestyle
Medical
Music
Navigation
News
Photo & Video
Productivity
Reference
Shopping
Social Networking
Sports
Travel
Utilities
Weather

2. Which is the genre with the most apps rated?

Games 

3. Which is the genre with most apps?

Games 

4. Which is the one with least?

Medical

5. Find the top 10 apps most rated.

Facebook	Social Networking	2974676
Pandora - Music & Radio	Music	1126879
Pinterest	Social Networking	1061624
Bible	Reference	985920
Angry Birds	Games	824451
Fruit Ninja Classic	Games	698516
Solitaire	Games	679055
PAC-MAN	Games	508808
Calorie Counter & Diet Tracker by MyFitnessPal	Health & Fitness	507706
The Weather Channel: Forecast, Radar & Alerts	Weather	495626

6. Find the top 10 apps best rated by users.

The Photographer's Ephemeris
J&J Official 7 Minute Workout
Daily Audio Bible App
Plants vs. Zombies
Learn English quickly with MosaLingua
Domino's Pizza USA
Kurumaki Calendar -month scroll calendar-
Fragment's Note
Dragon Island Blue
TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF

7. Take a look at the data you retrieved in question 5. Give some insights.
By far, top 3 gathers Social Networking app (Facebook being the leader, with 2x more ratings than the second).
Otherwise, we will find Games, Health and Lifestyle (including Religion, Bible).

8. Take a look at the data you retrieved in question 6. Give some insights.
I would be more cautious on this sample of 10 best rated apps since 1. many other apps are not captures and 2. we are missing number of ratings which is a way to assess relevance (for instance, 5 stars rating with only one rating is not as relevant as 4.8 with 100 ratings).

9. Now compare the data from questions 5 and 6. What do you see?
We can find common genres with previous question such as Lifestyle, Games, Sport/Health or Religion. 
New genre pops such as "convenient app": scanning document, calendar or food delivery apps.

10. How could you take the top 3 regarding both user ratings and number of votes?
By adding two elements in the ORDER BY clause:

SELECT track_name, user_rating, rating_count_tot
FROM ironhack_examples.applestore
ORDER BY user_rating DESC, rating_count_tot DESC
LIMIT 3;

11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
Retrieving the top 10 most rated apps (as a way to measure popularity and adoption), I can notice that 3 out of 10 apps are free and the rest's price ranged from [0.99 to 4.99$].
=> This leads to a first intuition : price does not seem to matter (an app should not necessarily be free) BUT price point should be accessible (1 to 5 dollars).

Plants vs. Zombies	426463	0.99
Domino's Pizza USA	258624	0
Plants vs. Zombies HD	163598	0.99
TurboScan Pro - document & receipt scanner: scan multiple pages and photos to PDF	28388	4.99
Sworkit - Custom Workouts for Exercise & Fitness	16819	0
Fieldrunners 2	14214	2.99
Headspace	12819	0
:) Sudoku +	11447	2.99
Dragon Island Blue	9119	0.99
Sudoku +	5397	4.99

Also, when we retrieve top 10 app by price (DESC order): we find that the most expensive app is a pro-app with a cost of 249$ and the second app is priced at 25$ which is a drastic drop.
We can conclude that except few exceptions (like pro-app), most of apple store apps fall under a "cheap/accessible" bucket. 

Proloquo2Go - Symbol-based AAC	249.99	773	4
STEINS;GATE	24.99	16	4
iStatVball 2 iPad Edition	19.99	193	4.5
Gaia GPS Classic	19.99	2429	4.5
Notion	14.99	929	4
FiLMiC Pro	14.99	1478	3
FL Studio Mobile	13.99	818	3.5
iAnnotate PDF	9.99	11156	4.5
Jesus Calling Devotional by Sarah Young	9.99	1685	2.5
Notability	9.99	17594	4
