Feature: Survey export
  As an api consumer
  I want to represent a survey in JSON
  So that I can use it offline

  Scenario: Exporting basic questions
    Given I parse
    """
      survey "Simple json" do
        section "Basic questions" do
          label "These questions are examples of the basic supported input types"

          question_1 "What is your favorite color?", :pick => :one
          answer "red"
          answer "blue"
          answer "green"
          answer :other

          q_2b "Choose the colors you don't like", :pick => :any
          a_1 "orange"
          a_2 "purple"
          a_3 "brown"
          a :omit
        end
      end
    """
    Then the json for "Simple json" should be
    """
    {
      "title": "Simple json",
      "uuid": "*",
      "sections": [{
        "title": "Basic questions",
        "display_order":0,
        "questions_and_groups": [
          { "uuid": "*", "type": "label", "text": "These questions are examples of the basic supported input types" },
          { "uuid": "*", "reference_identifier": "1", "pick": "one", "text": "What is your favorite color?", "answers": [{"text": "red", "uuid": "*"}, {"text": "blue", "uuid": "*"}, {"text": "green", "uuid": "*"}, {"text": "Other", "uuid": "*"}]},
          { "uuid": "*", "reference_identifier": "2b", "pick": "any", "text": "Choose the colors you don't like", "answers": [{"text": "orange", "uuid": "*"},{"text": "purple", "uuid": "*"},{"text": "brown", "uuid": "*"},{"text": "Omit", "exclusive":true, "uuid": "*"}]}]
        }]
      }
    """
  
#   Scenario: Exporting response sets
#   Given I parse
#   """
#     survey "Simple json response sets" do
#       section "Colors" do
# 
#         question_1 "What is your favorite color?", :pick => :one
#         answer "red"
#         answer "blue"
#         answer "green"
#         answer :other
# 
#         q_2b "What color don't you like?"
#         a_1 "color", :string
#       end
#     end
#   """
# When I start the "Simple json" survey
# And I choose "red"
# And I fill in "color" with "orange"
# And I press "Click here to finish"
# Then there should be 1 response set with 2 responses with:
#   | answer |
#   | red    |
#   | orange |
# And the json for the last response set should be
# """
# { 
#   "uuid":"*",
#   "survey_id":"*",
#   "created_at":"*",
#   "completed_at":"*",
#   "responses":[{
#     "uuid":"*",
#     "answer_id":"*",
#     "question_id":"*"
#     "created_at":"*",
#     "modified_at":"*"
#   },{
#     "uuid":"*",
#     "answer_id":"*",
#     "question_id":"*"
#     "created_at":"*",
#     "modified_at":"*"
#   }]
# }
# """