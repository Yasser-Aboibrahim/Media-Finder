# Media-Finder
An application to play movies, songs or Tv-shows from iTunes Search API by using Alamofire and pars the data.<br/>
Store the user data and the last search result for each user in a database by using SQLite.<br/>
# 1- Sign Up View
It contains user name, user email, password, user image, user gender and user address.<br/>
 When the user clicks on Sign Up button<br/>
- In case he/she entered invalid data or the user data entry is not completed he/she should see an alert tell him/her what is wrong.
<br><br>
<img src = "MediaFinderPics/SignUp1.PNG" width = 200 hight = 200> 
- In case he/she clicks on the image button the image picker will allow the user to pick an image from the galary when he/she choose the image the sign up view will display.
<br><br>
<img src = "MediaFinderPics/ImagePicker.PNG" width = 200 hight = 200> 
- In case he/she clicks on the address the map view will display and allow the user to get the address from the center location of the map then click confirm to send the address and the sign up view will display.
<br><br>
<img src = "MediaFinderPics/Map.PNG" width = 200 hight = 200> 
- Sign up view after getting the address and the map.
<br><br>
<img src = "MediaFinderPics/SignUp2.PNG" width = 200 hight = 200> 

# 2- Sign In View
It contains user email and password.<br/>
- In case the user already has an account and he/she try to log in via Sign In screen you must validate email and password as in the database.<br/>
- In case he/she entered invalid data he/she should see an alert tell him/her what is wrong.<br/>
- In case he/she entered valid data you must check if these credentials exist on the database or not to decide to let him/her in or alert him/her with invalid credentials alert.<br/>
<br><br>
<img src = "MediaFinderPics/SignIn.PNG" width = 200 hight = 300> 

# 3- Media List View
It contains a search bar for the Media name ,Sigmented buttons to choose the type of the media (movies-songs-tv-shows) and a table view to show the result of the search.<br/>
Examples:<br/>
- The user has searched for Adele and of type song.
<br><br>
<img src = "MediaFinderPics/MovieListSongs.PNG" width = 200 hight = 200> 
- The user has searched for xmen and of type movie.
<br><br>
<img src = "MediaFinderPics/MovieListMovies.PNG" width = 200 hight = 200> 
- The user has searched for xmen and of type tv-show.
<br><br>
<img src = "MediaFinderPics/MovieListTV-Shows.PNG" width = 200 hight = 200> 
- The user has searched for something with no result.
<br><br>
<img src = "MediaFinderPics/MovieListNotFound.PNG" width = 200 hight = 200> 

# 4-Profile
It contains the user information.
<br><br>
<img src = "MediaFinderPics/Profile.PNG" width = 200 hight = 200> 
