#  PokemonMVP

This application shows **a list with all pokemon characters**.

## Functionality

This app offers a main view based on a table view that displays a collection of characters. This list is always ordered and also allows an user to **search any pokemon** using a search bar. 

For **performance** reasons, this app ask to the server for **only 20 characters per request**. So, any time an user reachs the bottom list, a new request is performed with next offset.

When a user taps any character cell, a detail view with picture, abilites and types is shown(this view offers **landscape support**).

## Ligth/dark mode

This app supports light and dark mode.

## Architecture

**MPV**  is great for unit testing due to having the business logic isolated from the view. Also, this model has a good balance between layer complexity and simplicity, so if the app has a small-medium size, it could fit in most of the cases. 

In order to save a current pokemon list of an user , the application uses **Core Data**.

![alt text](https://miro.medium.com/max/1556/1*p2JvbgEir0BusDiiVHMvIA.png "VIPER image")

## Third party library

[SDWebImage](https://github.com/SDWebImage/SDWebImage "SDWebImage")

## Testing

The project contains 2 main tests

* Presenter service testing
* Presenter default business logic testing

## Pending improvement points

* Improve error handling
* Core data testing
* Search by name againts server using search bar
* UI testing
* Full pokemon management offline
* Front design
