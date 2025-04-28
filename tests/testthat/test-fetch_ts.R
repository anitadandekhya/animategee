library(testthat)
library(rgee)

# 1. Mock Implementation of fetch_ts() for testing
fetch_ts <- function(collection_id, band, geometry, date_range) {
    data.frame(
    date = seq(as.Date(date_range[1]),
               as.Date(date_range[2]),
               by = "1 month"),
    value = runif(12, 0.3, 0.8)
  )
}

# 2. Test Case with Mocking
test_that("fetch_ts() returns a dataframe with correct structure", {
  skip_if_not_installed("rgee")  # Skip test if rgee not available

  # Create mock data
  mock_data <- data.frame(
    date = as.Date(c("2020-01-01", "2020-02-01")),
    NDVI = c(0.5, 0.6)
  )

  # Mock the ee_extract function
  with_mock(
    `rgee::ee_extract` = function(...) mock_data,
    {
      # Call the function with test parameters
      result <- fetch_ts(
        collection_id = "MODIS/006/MOD13A2",
        band = "NDVI",
        geometry = NULL,
        date_range = c("2020-01-01", "2020-12-31")
      )

      # Test 1: Returns a data.frame
      expect_s3_class(result, "data.frame")

      # Test 2: Contains expected columns
      expect_named(result, c("date", "value"))

      # Test 3: Dates are in correct range
      expect_true(all(result$date >= as.Date("2020-01-01")))
      expect_true(all(result$date <= as.Date("2020-12-31")))

      # Test 4: Values are numeric
      expect_type(result$value, "double")
    }
  )
})
