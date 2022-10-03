# SpaceXFan

#############--------------- Running Project ------------------------############

1- Clone or Download the Project
   - Firstly run "pod install" command 


#############--------------- About Project------------------------############


- This Project has three tabs.
  - All SpaceX rockets
  - Favorite rockets
  - Upcoming launches

1- First Tab : All SpaceX rockets
   - You can see the all rockets and little description about itself.
   - You can see the all knowledges  from detail page after clicking the any rocket.
   - If you have no logged in before, you can login from the upper right corner with login button.
   - In the login page, you can register with an email and password with "Sign Up" button. 
   - In the login page, you can enter with an email and password with "Sign In" button.
   - Also, after logging in in the upper right corner of this page, the "Log Out" button will appear. If you want, you can exit here
   - The email and password I used for the test before are as follows. You can also log in after registering with a new e-mail and password.
     -e-mail   : ademkaya@ios.com  
     -password : 123456
   - if you have no logged in before, you can not use favorite button. If you click the favorite button, you will be redirected to the login page.
   - If there are rockets that you have logged in and added to your favorites before, you can see them again after logging in.

2- Second Tab : Favorite Tab
   - If you click on this page without logging in, it will direct you to the login page.
   - After logging in, if you have a favorite rocket, you can see it on this tab.
   - If you have added a favorite rocket and want to remove it later, you can do so on this page.
   - The rockets you have removed from your favorite here will also be removed from your favorites on the first tab. You can test this by going to the
      first tab. To put it briefly, the favorite button can be used actively on this tab.

3- Third Tab : Upcoming Launches
   - This tab shows all upcoming lounches.
   - You can see the all knowledges after clicking the rocket.


#############--------------- Additional Pages ------------------------############

- Also SpaceXFan have two pages
  - Detail Page 
  - Login Page

1- Detail Page
   - You can reach from all tabs after logging in. 
   - If have no login, you can not reach detail page from favorite tab.
   - If you have login and reach this page from first and second tab, you can use the favorite button.
 
2- Login Page
   - you can reach from the upper right corner with login button in the first tab.
   - You can reach after cicking from favorite button in detail page and first tab, if you have no login.



#############--------------- Completed Parts ------------------------############

- [x] 1- Has three tabs 
   - Listing all SpaceX rockets 
   - Listing favorite rockets
   - Listing upcoming launches
   
- [x] 2- First tab: SpaceX Rockets
   - List all SpaceX rockets
   - Each rocket card in the list must have favorite button
   - Previous favorite state should be stored (user selected the rocket as favorite or not)
   - Each item must have a thumbnail of the rocket (if rocket has images)
   - Clicking an item will launch the rocket detail page

- [x] 3- Rocket Detail Page
   - Show information of the rocket
   - Show rocket images in a slidable gallery 
   - Show the clickable favorite button with its previous state (user selected the rocket as favorite or not) 

- [x] 4- Second tab: Favorite Rockets
   - List favorite rockets of the user
   - Each item must have unfavorite button
   - Clicking an item will launch the rocket detail page
   - This tab should be entered via Fingerprint or Firebase Email/Password
     - Authentication
       - ii. Firebase Email Authentication 
      
- [x] 5- Third tab: Upcoming Launches
   - List upcoming launches 
   - Clicking an item will open detail page of the upcoming launch

- [x] 6- The application should know its state when the user pushes it in the background. For example,
   - I opened a rocket detail in the "SpaceX Fan" application
   - I received a Slack message and opened Slack message 
   - I then returned to "SpaceX Fan”; the state should be the same as when I left "SpaceX Fan".

- [x] 7. (BONUS) Create a cloud service on any cloud service provider (Amazon, DigitalOcean, Google, Firebase etc.) free services provided are enough to handle. Create a primitive user login and dummy user database on cloud. Keep favorite rockets of dummy users on the cloud and make appropriate changes on mobile applications.


#############--------------- What I have used ------------------------############

- [x] ImageSlideshow
- [x] ImageSlideshow/Kingfisher
- [x] Alamofire
- [x] SwiftyJSON
- [x] FirebaseAuth
      - SignIn
      - SignUp
      - SignOut

- [x] FirebaseFirestore
      - setData
      - getData
      - deleteData

- [x] NotificationCenter
- [x] configureNavigationBar + With Large Title
- [x] MVVM
- [x] AutoLayout Constraints
- [x] UIAlertController
- [x] StackView
- [x] Protocol
- [x] Delegate
- [x] Image Assets
- [x] SF Symbols
- [x] Programmatic UI
- [x] UITableViewController 


![Screenshot 2022-10-04 at 00 47 36](https://user-images.githubusercontent.com/15779920/193692168-6a3a790b-e136-4299-a7e4-fa81b7be13bf.png)


![Screenshot 2022-10-04 at 00 47 55](https://user-images.githubusercontent.com/15779920/193692182-6c6884a9-18ef-4083-b80f-83207acc3875.png)


- you can reach project video from this below link 
  - https://drive.google.com/file/d/1xm_X1aCghDb-uC74YU299PIpN8LCfu2S/view?usp=sharing
