Feature: Add new movie 

  As a movie goer
  So that I can have my movie list updated with new movies 
  I want to add new movies to the movie list

Background: movies in database

  Given the following movies exist:
  | title        | rating | director     | release_date |
  | Star Wars    | PG     | George Lucas |   1977-05-25 |
  | Blade Runner | PG     | Ridley Scott |   1982-06-25 |
  | Alien        | R      |              |   1979-05-25 |
  | THX-1138     | R      | George Lucas |   1971-03-11 |

Scenario: And new movie
  When I am on the RottenPotatoes home page
  And  I follow "Add new movie"
  And  I fill in "Director" with "Ridley Scott"
  And  I fill in "Title" with "Chocolat"
  And  I press "Save Changes"
  Then I should see "Chocolat"
  And  I should be on the RottenPotatoes home page
  