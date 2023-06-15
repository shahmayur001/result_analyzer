Feature: Result Analyzer
  As a user of the result management system
  I want to ensure that result data is received and processed correctly
  So that I can calculate daily result stats and monthly averages

  Scenario: Receive result data from MSM
    When I send a POST request to results_data_path with the following JSON:
      """
      {"subject": "Science", "timestamp": "2022-04-18 12:01:34.678", "marks": 85.25}
      """
    Then the response status should be 200

  Scenario: Calculate Daily Result Stats for a subject
    Given there are the following result data for subject Science:
    """
      [
        {"subject": "Science", "timestamp": "2022-04-18 12:02:44.678", "marks": 123.54},
        {"subject": "Science", "timestamp": "2022-04-18 13:37:26.678", "marks": 120.99},
        {"subject": "Science", "timestamp": "2022-04-18 15:33:23.678", "marks": 126.76},
        {"subject": "Science", "timestamp": "2022-04-18 17:21:55.678", "marks": 119.88},
        {"subject": "Science", "timestamp": "2022-04-18 17:47:27.678", "marks": 125.21} 
      ]
    """
    When I calculate the Daily Result Stats for subject Science
    Then the following result stats should be calculated for them:
    """
      {"date": "2022-04-18", "subject": "Science", "daily_low": 119.88, "daily_high": 126.76, "daily_volume": 5}
    """

  Scenario: Calculate Monthly Average for a subject if today is Monday of week of third Wednesday
    Given there are the following daily result stats:
    """
      [
        {"date": "2022-04-07", "subject": "Science", "daily_low": 119.88, "daily_high": 126.76, "daily_volume": 18},
        {"date": "2022-04-08", "subject": "Science", "daily_low": 123.73, "daily_high": 127.23, "daily_volume": 11},
        {"date": "2022-04-11", "subject": "Science", "daily_low": 121.12, "daily_high": 124.52, "daily_volume": 12},
        {"date": "2022-04-12", "subject": "Science", "daily_low": 117.22, "daily_high": 120.11, "daily_volume": 81},
        {"date": "2022-04-13", "subject": "Science", "daily_low": 118.84, "daily_high": 119.29, "daily_volume": 22},
        {"date": "2022-04-14", "subject": "Science", "daily_low": 120.27, "daily_high": 123.33, "daily_volume": 57},
        {"date": "2022-04-15", "subject": "Science", "daily_low": 126.01, "daily_high": 128.77, "daily_volume": 23},
        {"date": "2022-04-18", "subject": "Science", "daily_low": 124.30, "daily_high": 125.58, "daily_volume": 12}
      ]
    """
    When I calculate the monthly averages
    Then the following monthly average should be calculated for them:
    """
      {"date": "2022-04-18", "subject": "Science", "monthly_avg_low": 121.29, "monthly_avg_high": 123.60, "monthly_result_count_used": 207}
    """
