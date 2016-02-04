Feature: Merge Articles
  As a blog administrator
  In order to reduce duplicate content 
  I want to be able to merge two articles together

  Background:
    Given the blog is set up
    And I am logged into the admin panel
    And the following articles exist:
      | id | title        | body              |
      |  3 | Article 1    | Body for a1       |
      |  4 | Article 2    | Body for a2       |
    And the following comments exist:
      | id | author       | user_id | body          | article_id |
      |  1 | john         | 1       | hello john    | 3          |
      |  2 | mary         | 2       | hi5 !         | 4          |


  Scenario: Successfully merge articles
    Given I am on the articles page for "Article 1"
    Then I should see merge_with
    And I fill in "merge_with" with "4"  
    And I press "Merge"
    Then the article "Article 1" should have body "Body for a1 Body for a2"
    And the comment "hi5 !" should belong to "Article 1" 
    And I should be on the articles page for "Article 1"

  Scenario: Get error message when trying to merge with nonexistent article
    Given I am on the articles page for "Article 1"
    And I fill in "merge_with" with "5"
    And I press "Merge"
    Then the article "Article 1" should have body "Body for a1"
    And I should be on the articles page for "Article 1"
    And I should see a helpful error message

  Scenario: Get error message when trying to merge with itself
    Given I am on the articles page for "Article 1"
    And I fill in "merge_with" with "3"
    And I press "Merge"
    Then the article "Article 1" should have body "Body for a1"
    And I should be on the articles page for "Article 1"
    And I should see a helpful error message